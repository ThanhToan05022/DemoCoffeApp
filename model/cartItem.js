const mongoose = require("mongoose");

const cartItemSchema = mongoose.Schema(
  {
    products: {
      type: mongoose.Types.ObjectId,
      ref: "Products",
      required: true,
    },
    cart: {
      type: mongoose.Types.ObjectId,
      ref: "Cart",
    },
    quantity: {
      type: Number,
      required: true,
      min: 1,
    },
    Size: {
      type: String,
    },
    price: {
      type: Number,
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("CartItem", cartItemSchema);
