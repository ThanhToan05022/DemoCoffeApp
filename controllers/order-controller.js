const Cart = require("../model/Cart");
const cartItem = require("../model/cartItem");
const Order = require("../model/Order");
const createCart = async (req, res) => {
  try {
    const { productId, quantity, price, size } = req.body;
    const userId = req.user.userId;

    const qty = Number(quantity);
    const priceNum = Number(price);

    let cart = await Cart.findOne({ user: userId }).populate("items");

    if (!cart) {
      const newItem = await cartItem.create({
        products: productId,
        quantity: qty,
        Size: size,
        price: priceNum,
      });

      cart = await Cart.create({
        user: userId,
        items: [newItem._id],
        totalPrice: priceNum * qty,
      });
    } else {
      // 🔥 tìm item trùng product + size
      const existedItem = await cartItem.findOne({
        _id: { $in: cart.items },
        products: productId,
        Size: size,
      });

      if (existedItem) {
        existedItem.quantity += qty;
        await existedItem.save();
      } else {
        const newItem = await cartItem.create({
          products: productId,
          quantity: qty,
          Size: size,
          price: priceNum,
        });
        cart.items.push(newItem._id);
      }

      cart.totalPrice += priceNum * qty;
      await cart.save();
    }

    cart = await Cart.findById(cart._id).populate({
      path: "items",
      populate: { path: "products", model: "Products" },
    });

    return res.status(200).json({
      success: true,
      message: "Item added to cart",
      data: cart,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ success: false });
  }
};

const getCart = async (req, res) => {
  try {
    const userId = req.user.userId;
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
const deleteOrders = async (req, res) => {
  try {
    const userId = req.user.userId;
    const itemId = req.params.id;

    const item = await cartItem.findById(itemId);
    if (!item) {
      return res.status(404).json({
        success: false,
        message: "Item not found",
      });
    }

    const cart = await Cart.findOne({ user: userId });
    if (!cart) {
      return res.status(404).json({
        success: false,
        message: "Cart not found",
      });
    }

    const itemTotal = item.price * item.quantity;
    cart.totalPrice -= itemTotal;

    cart.items.pull(itemId);
    await cart.save();

    await cartItem.findByIdAndDelete(itemId);

    return res.status(200).json({
      success: true,
      message: "Item deleted",
      data: {
        itemId,
        totalPrice: cart.totalPrice,
      },
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({
      success: false,
      message: "Delete failed",
    });
  }
};
const checkout = async (req, res) => {
  try {
    const userId = req.user.userId;

    const cart = await Cart.findOne({ user: userId }).populate("items");
    if (!cart || cart.items.length === 0) {
      return res.status(400).json({
        success: false,
        message: "Cart is empty",
      });
    }

    const orderItems = [];

    for (const item of cart.items) {
      const newItem = await cartItem.create({
        products: item.products,
        quantity: item.quantity,
        Size: item.Size,
        price: item.price,
      });
      orderItems.push(newItem._id);
    }

    const order = await Order.create({
      user: userId,
      items: orderItems,
      totalPrice: cart.totalPrice,
    });

    // clear cart
    await cartItem.deleteMany({ _id: { $in: cart.items } });
    cart.items = [];
    cart.totalPrice = 0;
    await cart.save();

    return res.status(200).json({
      success: true,
      message: "Checkout successful",
      data: order,
    });
  } catch (err) {
    console.error("Checkout error:", err);
    return res.status(500).json({
      success: false,
      message: "Checkout failed",
    });
  }
};

const getInvoices = async (req, res) => {
  try {
    const userId = req.user.userId;

    const orders = await Order.find({ user: userId })
      .sort({ createdAt: -1 })
      .populate({
        path: "items",
        populate: { path: "products", model: "Products" },
      });

    const formatted = orders.map((order) => {
      // ✅ Items đã merged từ checkout, không cần group lại
      // Nhưng vẫn giữ logic này để safe
      const groupedItems = {};

      order.items.forEach((it) => {
        if (!it.products) return;

        const key = `${it.products._id}_${it.Size || ""}`;

        if (!groupedItems[key]) {
          groupedItems[key] = {
            products: it.products,
            size: it.Size || null,
            quantity: 0,
            price: it.price,
            lineTotal: 0,
          };
        }

        groupedItems[key].quantity += it.quantity;
        groupedItems[key].lineTotal += it.price * it.quantity;
      });

      return {
        orderId: order._id,
        date: order.createdAt,
        items: Object.values(groupedItems),
        totalPrice: order.totalPrice,
      };
    });

    return res.status(200).json({
      success: true,
      data: formatted,
    });
  } catch (error) {
    console.error("Get invoices error:", error);
    return res
      .status(500)
      .json({ success: false, message: "Failed to get invoices" });
  }
};
module.exports = { createCart, getCart, deleteOrders, checkout, getInvoices };
