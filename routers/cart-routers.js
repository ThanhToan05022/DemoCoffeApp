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
 * /api/getCart:
 *   get:
 *     summary: Lấy giỏ hàng của người dùng hiện tại
 *     tags: [Orders]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Giỏ hàng hiện tại (populated items)
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data:
 *                   $ref: '#/components/schemas/Cart'
 *       400: { description: Thiếu userId }
 *       401: { description: Unauthorized }
 *       404: { description: Không tìm thấy giỏ hàng }
 *       500: { description: Lỗi máy chủ }

/**
 * @swagger
 * /api/checkout:
 *   post:
 *     summary: Thanh toán (checkout) - tạo Order từ Cart
 *     tags: [Orders]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Checkout successful, trả về order
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 message: { type: string }
 *                 data:
 *                   $ref: '#/components/schemas/Order'
 *       400: { description: Cart trống }
 *       401: { description: Unauthorized }
 *       500: { description: Lỗi máy chủ }
 */

/**
 * @swagger
 * /api/invoices:
 *   get:
 *     summary: Lấy danh sách hoá đơn (orders) của người dùng
 *     tags: [Orders]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Danh sách hoá đơn đã format
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       orderId: { type: string }
 *                       date: { type: string, format: date-time }
 *                       items: { type: array }
 *                       totalPrice: { type: number }
 *       401: { description: Unauthorized }
 *       500: { description: Lỗi máy chủ }
 */

/**
 * @swagger
 * /api/deleteOrders/item/{id}:
 *   delete:
 *     summary: Xóa một mục trong giỏ hàng theo item id
 *     tags: [Orders]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string }
 *         description: CartItem id
 *     responses:
 *       200:
 *         description: Item deleted
 *       401: { description: Unauthorized }
 *       404: { description: Item or Cart not found }
 *       500: { description: Lỗi máy chủ }
 */
 
// ...existing code...
