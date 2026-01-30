const express = require("express");
const router = express.Router();
const {
  createCart,
  getCart,
  deleteOrders,
  checkout,
  getInvoices
} = require("../controllers/order-controller");
const authMiddleware = require("../middleware/auth-middleware");
router.post("/createCart", authMiddleware, createCart);
router.get("/getCart/", authMiddleware, getCart);
router.post("/checkout", authMiddleware, checkout);
router.get("/invoices", authMiddleware, getInvoices);
router.delete("/deleteOrders/item/:id",authMiddleware,deleteOrders);
module.exports = router;

/**
 * @swagger
 * tags:
 *   - name: Orders
 *     description: Quản lý giỏ hàng/đơn hàng của người dùng
 */

/**
 * @swagger
 * /api/createCart:
 *   post:
 *     summary: Thêm sản phẩm vào giỏ hàng
 *     tags: [Orders]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [ productId, quantity, price]
 *             properties:      
 *               productId: { type: string }
 *               quantity: { type: integer, minimum: 1 }
 *               size: { type: string, nullable: true }
 *               price: { type: number }
 *     responses:
 *       200:
 *         description: Đã thêm vào giỏ
 *       400: { description: Thiếu trường bắt buộc }
 *       401: { description: Unauthorized }
 *       500: { description: Lỗi máy chủ }
 */

/**
 * @swagger
 * /api/getCart/{user}:
 *   get:
 *     summary: Lấy giỏ hàng theo userId
 *     tags: [Orders]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Giỏ hàng hiện tại
 *       400: { description: Thiếu userId }
 *       401: { description: Unauthorized }
 *       404: { description: Không tìm thấy giỏ hàng }
 *       500: { description: Lỗi máy chủ }
 */
// ...existing code...
