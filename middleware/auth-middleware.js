const jwt = require("jsonwebtoken");
const BlacklistedToken = require("../model/BlacklistedToken");

const authMiddleware = async (req, res, next) => {
  const authHeader = req.headers["authorization"];

  const token = authHeader && authHeader.split(" ")[1];
  if (!token) {
    return res.status(400).json({
      success: false,
      message: "Access denied. No token provided. Please login to continue",
    });
  }

  try {
    const blacklisted = await BlacklistedToken.findOne({ token });
    if (blacklisted) {
      return res
        .status(401)
        .json({
          success: false,
          message: "Token revoked. Please login again.",
        });
    }

    const decodedToken = jwt.verify(token, process.env.TOKEN_SECRET);
    req.user = decodedToken;

    next();
  } catch (error) {
    return res.status(401).json({
      success: false,
      message: "Access denied. Invalid token. Please login to continue",
    });
  }
};

module.exports = authMiddleware;
