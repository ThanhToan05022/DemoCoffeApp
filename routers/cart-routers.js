const express = require("express");
const router = express.Router();
const { createCart, getCart } = require("../controllers/order-controller");
const authMiddleware = require("../middleware/auth-middleware");
router.post("/createCart", authMiddleware, createCart);
router.get("/getCart/:user", authMiddleware, getCart);

module.exports = router;
// ...existing code...

/**
 * @swagger
 * tags:
 *   - name: Orders
 *     description: Quản lý giỏ hàng/đơn hàng của người dùng
 */

/**
 * @swagger
 * /api/cart:
 *   post:
 *     summary: Thêm sản phẩm vào giỏ hàng
 *     tags: [Orders]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [userId, productId, quantity, price]
 *             properties:
 *               userId: { type: string }
 *               productId: { type: string }
 *               quantity: { type: integer, minimum: 1 }
 *               size: { type: string, nullable: true }
 *               price: { type: number }
 *     responses:
 *       200:
 *         description: Đã thêm vào giỏ
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 message: { type: string }
 *                 cart: { $ref: "#/components/schemas/Cart" }
 *       400: { description: Thiếu trường bắt buộc }
 *       500: { description: Lỗi máy chủ }
 */

/**
 * @swagger
 * /api/cart/{user}:
 *   get:
 *     summary: Lấy giỏ hàng theo userId
 *     tags: [Orders]
 *     parameters:
 *       - in: path
 *         name: user
 *         required: true
 *         schema: { type: string }
 *         description: userId
 *     responses:
 *       200:
 *         description: Giỏ hàng hiện tại
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data: { $ref: "#/components/schemas/Cart" }
 *       404: { description: Không tìm thấy giỏ hàng }
 *       400: { description: Thiếu userId }
 *       500: { description: Lỗi máy chủ }
 */

// ...existing code...
