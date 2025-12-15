const Cart = require("../model/Cart");
const cartItem = require("../model/cartItem");

const createCart = async (req, res) => {
  try {
    const { user, productId, quantity, size, price } = req.body;
    if (!user || !productId || !quantity || !price) {
      return res.status(400).json({
        success: false,
        message: "Missing required fields",
      });
    }
    const newItem = await cartItem.create({
      products: productId,
      quantity,
      Size: size,
      price,
    });
    let cart = await Cart.findOne({ user: user }).populate({
      path: "items",
      populate: { path: "products", model: "Products" },
    });
    if (!cart) {
      cart = await Cart.create({
        user: user,
        items: newItem,
        totalPrice: price * quantity,
      });
    } else {
      cart.items.push(newItem);
      cart.totalPrice += price * quantity;
      await cart.save();
    }
    return res.status(200).json({
      success: true,
      message: "Item added to cart",
      cart: cart,
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
    if (!userId) {
      return res
        .status(400)
        .json({ success: false, message: "Missing userId" });
    }
    const getCart = await Cart.findOne({ user: userId }).populate({
      path: "items",
      populate: { path: "products", model: "Products" },
    });
    if (!getCart) {
      return res
        .status(404)
        .json({ success: false, message: "Cart not found" });
    }
    return res.status(200).json({
      success: true,
      data: getCart,
    });
  } catch (error) {
    console.error("Error creating product:", error);
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

module.exports = { createCart, getCart };
