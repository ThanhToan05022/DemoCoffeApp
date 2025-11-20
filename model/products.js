const mongoose = require("mongoose");

const productsSchema = mongoose.Schema(
  {
    Name: {
      type: String,
      required: true,
    },
    Price: {
      type: Number,
      min: 0,
    },
    Description: {
      type: String,
      maxlength: 200,
    },
    Category: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Category",
      required: true,
    },
    imageUrl: {
      type: String,
      optional: true,
    },
    Rating: {
      type: String,
    },
    Size: {
      type: String,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Products", productsSchema);
