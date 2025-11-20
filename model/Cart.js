const mongoose = require("mongoose");

const cartSchema = mongoose.Schema(
  {
    user: {
      type: mongoose.Types.ObjectId,
      ref: "User",
    },
    totalPrice: {
      type: Number,
      default: 0,
    },
    items: [
      {
        type: mongoose.Types.ObjectId,
        ref: "CartItem",
      },
    ],
    paymentMethod: {
      type: String,
    },
    orderDate: {
      type: Date,
      default: Date.now,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Cart", cartSchema);
