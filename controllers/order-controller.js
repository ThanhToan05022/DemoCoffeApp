const mongoose = require('mongoose');
const Cart = require("../model/Cart");
const CartItem = require("../model/cartItem");

const createCart = async (req, res) => {
  try {
    const { userId, productId, quantity, size, price } = req.body;

    // Basic validation
    if (!userId || userId === 'null' || !productId || !quantity || !price) {
      return res.status(400).json({ success: false, message: "Missing required fields" });
    }
    if (!mongoose.Types.ObjectId.isValid(userId)) {
      return res.status(400).json({ success: false, message: "Invalid user id" });
    }
    if (!mongoose.Types.ObjectId.isValid(productId)) {
      return res.status(400).json({ success: false, message: "Invalid product id" });
    }

    // Create cart item (store product id as ObjectId)
    const newItem = await CartItem.create({
      products: mongoose.Types.ObjectId(productId),
      quantity,
      Size: size,
      price,
    });


    let cart = await Cart.findOne({ user: mongoose.Types.ObjectId(userId) }).populate({
      path: "items",
      populate: { path: "products", model: "Products" },
    });

    if (!cart) {
      cart = await Cart.create({
        user: mongoose.Types.ObjectId(userId),
        items: [newItem._id],
        totalPrice: price * quantity,
      });
    } else {
      
      cart.items.push(newItem._id);
      cart.totalPrice = (cart.totalPrice || 0) + price * quantity;
      await cart.save();
    }

    cart = await Cart.findById(cart._id).populate({
      path: "items",
      populate: { path: "products", model: "Products" },
    });

    return res.status(200).json({
      success: true,
      data: cart,
    });
  } catch (error) {
    console.error("Error creating product:", error);
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const getCart = async (req, res) => {
  try {
    const userId = req.params.user;
    if (!userId || userId === 'null') {
      return res.status(400).json({ success: false, message: "Missing userId" });
    }
    if (!mongoose.Types.ObjectId.isValid(userId)) {
      return res.status(400).json({ success: false, message: "Invalid user id" });
    }

    const foundCart = await Cart.findOne({ user: mongoose.Types.ObjectId(userId) }).populate({
      path: "items",
      populate: { path: "products", model: "Products" },
    });

    if (!foundCart) {
      return res.status(404).json({ success: false, message: "Cart not found" });
    }

    return res.status(200).json({
      success: true,
      data: foundCart,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const getAllOrders = async (req, res) => {
  try {
    const orders = await Cart.find({}).populate({
      path: "items",
      populate: { path: "products", model: "Products" },
    });
    return res.status(200).json({
      success: true,
      data: orders,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

module.exports = { createCart, getCart, getAllOrders };
