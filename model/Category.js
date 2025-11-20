const mongoose = require("mongoose");

const categorySchema = mongoose.Schema(
  {
    Name: { type: String, unique: true },
  },
  { timestamps: true }
);
module.exports = mongoose.model("Category",categorySchema);