const User = require("../model/users");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const upload = require("../middleware/upload-image");
require("dotenv").config();
//register
const registerUser = async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const avatar = req.file ? req.file.filename : null;
    const checkUser = await User.findOne({ $or: [{ name }, { email }] });
    // true
    if (checkUser) {
      return res.status(400).json({
        success: false,
        message: "User is already exists either with same username or email",
      });
    }

    // hash password
    const salt = await bcrypt.genSalt(10);
    const hashPassword = await bcrypt.hash(password, salt);

    const newUser = new User({
      name,
      email,
      password: hashPassword,
      avatar,
    });
    await newUser.save();
    if (newUser) {
      res.status(200).json({
        success: true,
        message: "user registered successfully",
      });
    } else {
      res.status(400).json({
        success: false,
        message: "User registration failed",
      });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
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

    // tao token
    const token = jwt.sign(
      {
        userId: user._id,
        email: user.email,
        name: user.name,
        avatar: user.avatar,
      },
      process.env.TOKEN_SECRET,
      {
        expiresIn: "1d",
      }
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
    const userId = req.userInfo.userId;
    const profile = await User.findById(userId);
    if (!profile) {
      return res.status(400).json({
        success: false,
        message: "Token error please try again",
      });
    }
    const profileWithImageUrl = profile.toObject();
    profileWithImageUrl.imageUrl = getFullImageUrl(req, profile.avatar);
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
      updatedData.avatar = req.file.filename;
    }
    const user = await User.findByIdAndUpdate(
      req.userInfo.userId,
      updatedData,
      {
        new: true,
        runValidators: true,
      }
    );
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
const getFullImageUrl = (req,fileName) => {
  if (!fileName) return null;
  const baseUrl =
    process.env.BASE_URL || `${req.protocol}://${req.get("host")}`;
  return `${baseUrl}/uploads/${fileName}`;
};
module.exports = { loginUser, registerUser, getProfile, updateProfile };
