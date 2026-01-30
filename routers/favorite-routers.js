const express = require("express");
const router = express.Router();
const {
  CreateFavorite,
  getFavorites,
  DeleteFavorite,
} = require("../controllers/favorite-controller");
const authMiddleware = require("../middleware/auth-middleware");
router.post("/createfavorite", authMiddleware, CreateFavorite);
router.get("/getFavorites", authMiddleware, getFavorites);
router.delete("/deleteFavorite/:products", authMiddleware, DeleteFavorite);
module.exports = router;

/**
 * @swagger
 * tags:
 *   - name: Favorites
 *     description: Quản lý danh sách yêu thích
 */

/**
 * @swagger
 * /api/createfavorite:
 *   post:
 *     summary: Thêm sản phẩm vào danh sách yêu thích
 *     tags: [Favorites]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               products: { type: string }
 *     responses:
 *       201:
 *         description: Đã thêm vào yêu thích
 *       400:
 *         description: Sản phẩm đã tồn tại
 *       401:
 *         description: Unauthorized
 */

/**
 * @swagger
 * /api/getFavorites:
 *   get:
 *     summary: Lấy danh sách yêu thích của người dùng
 *     tags: [Favorites]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Danh sách yêu thích
 *       401:
 *         description: Unauthorized
 */

/**
 * @swagger
 * /api/deleteFavorite/{products}:
 *   delete:
 *     summary: Xóa sản phẩm khỏi danh sách yêu thích
 *     tags: [Favorites]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: products
 *         required: true
 *         schema: { type: string }
 *         description: Product id
 *     responses:
 *       200:
 *         description: Đã xóa sản phẩm khỏi danh sách yêu thích
 *       401: { description: Unauthorized }
 *       404: { description: Không tìm thấy sản phẩm trong yêu thích }
 */
