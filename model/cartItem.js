const mongoose = require("mongoose");

let cartItemSchema = mongoose.Schema(
  {
    products: {
      type: mongoose.Types.ObjectId,
      ref: "Products",
    },
    cart: {
      type: mongoose.Types.ObjectId,
      ref: "Cart",
    },
    quantity: {
      type: Number,

      min: 1,
    },
    Size: {
      type: String,
    },
    price: {
      type: Number,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("CartItem", cartItemSchema);
