const User = require("../model/users");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const BlacklistedToken = require("../model/BlacklistedToken");
const upload = require("../middleware/upload-image");
require("dotenv").config();
//register
const registerUser = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const checkUser = await User.findOne({ $or: [{ name }, { email }] });
    if (checkUser) {
      return res.status(400).json({
        success: false,
        message: "User already exists",
      });
    }

    const salt = await bcrypt.genSalt(10);
    const hashPassword = await bcrypt.hash(password, salt);

    const avatarUrl = req.file ? req.file.location : null;

    const newUser = new User({
      name,
      email,
      password: hashPassword,
      avatar: avatarUrl,
    });

    await newUser.save();

    res.status(200).json({
      success: true,
      message: "User registered successfully",
      user: newUser,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      success: false,
      message: "Something went wrong!",
    });
  }
};

//login
const loginUser = async (req, res) => {
  try {
    const { email, password, avatar } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({
        success: false,
        message: "user doesn't exist",
      });
    }

    // so sánh mật khẩu người dùng nhập và mã hoá trong database

    const checkPassword = await bcrypt.compare(password, user.password);

    if (!checkPassword) {
      return res.status(400).json({
        success: false,
        message: "invalid credentials",
      });
    }
    const profileWithImageUrl = user.toObject();
    profileWithImageUrl.imageUrl = user.avatar || null;
    // tao token
    const token = jwt.sign(
      {
        userId: user._id,
        email: user.email,
        name: user.name,
        avatar: profileWithImageUrl.imageUrl,
      },
      process.env.TOKEN_SECRET,
      {
        expiresIn: "1d",
      },
    );

    res.status(200).json({
      success: true,
      user,
      message: "Login successfully!",
      token,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const getProfile = async (req, res) => {
  try {
    const userId = req.user.userId;
    const profile = await User.findById(userId);
    if (!profile) {
      return res.status(400).json({
        success: false,
        message: "Token error please try again",
      });
    }
    const profileWithImageUrl = profile.toObject();
    profileWithImageUrl.imageUrl = profile.avatar || null;
    res.status(200).json({
      success: true,
      profile: profileWithImageUrl,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const updateProfile = async (req, res) => {
  try {
    const { name, password, avatar } = req.body;
    const updatedData = {};
    if (name) {
      updatedData.name = name;
    }
    if (avatar) {
      updatedData.avatar = req.file;
    }
    // neu password moi
    if (password) {
      const salt = await bcrypt.genSalt(10);
      updatedData.password = await bcrypt.hash(password, salt);
    }
    if (req.file) {
      updatedData.avatar = req.file.location;
    }
    const user = await User.findByIdAndUpdate(req.user.userId, updatedData, {
      new: true,
      runValidators: true,
    });
    if (!user) {
      return res.status(400).json({
        success: false,
        message: "User not found",
      });
    }

    res.status(200).json({
      success: true,
      user,
      message: "Update successfully",
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};
const getFullImageUrl = (req, fileName) => {
  if (!fileName) return null;
  return fileName;
};
// module.exports = { loginUser, registerUser, getProfile, updateProfile };

// logout
const logoutUser = async (req, res) => {
  try {
    const authHeader = req.headers["authorization"];
    const token = authHeader && authHeader.split(" ")[1];

    if (!token) {
      return res
        .status(400)
        .json({ success: false, message: "No token provided" });
    }

    const already = await BlacklistedToken.findOne({ token });
    if (already) {
      return res.status(200).json({ success: true, message: "Logged out" });
    }

    const decoded = jwt.decode(token);
    const expiresAt =
      decoded && decoded.exp
        ? new Date(decoded.exp * 1000)
        : new Date(Date.now());

    await BlacklistedToken.create({ token, expiresAt });

    return res
      .status(200)
      .json({ success: true, message: "Logged out successfully" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ success: false, message: "Something went wrong" });
  }
};

module.exports = {
  loginUser,
  registerUser,
  getProfile,
  updateProfile,
  logoutUser,
};
