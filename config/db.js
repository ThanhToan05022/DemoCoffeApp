const mongoose = require("mongoose");

const connectToDB = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URL);
    console.log("MongoDB connected successfully!");
  } catch (error) {
    console.log("Mongodb error connection");
  }
};

module.exports = connectToDB;
