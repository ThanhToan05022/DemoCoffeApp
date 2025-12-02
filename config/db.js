const mongoose = require("mongoose");
require("dotenv").config();

const connectToDB = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URL); 
    console.log("MongoDB connected successfully!");
  } catch (error) {
    console.error("MongoDB connection error:", error); 
    throw error; 
  }
};

module.exports = connectToDB;
