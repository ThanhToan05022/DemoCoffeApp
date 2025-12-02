const express = require("express");

const router = express.Router();
const { createCategory,getAllCategory } = require("../controllers/category-controllers");
const authMiddleware = require("../middleware/auth-middleware");
router.post("/createCategory", authMiddleware, createCategory);
router.get("/getAllCategory", authMiddleware, getAllCategory);
module.exports = router;

// ...existing code...

/**
 * @swagger
 * tags:
 *   - name: Categories
 *     description: Quản lý danh mục
 */

/**
 * @swagger
 * /api/getAllCategory:
 *   get:
 *     summary: Lấy tất cả danh mục
 *     tags: [Categories]
 *     responses:
 *       200:
 *         description: Danh sách danh mục
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data:
 *                   type: array
 *                   items: { $ref: "#/components/schemas/Category" }
 */
 
/**
 * @swagger
 * /api/createCategory:
 *   post:
 *     summary: Tạo danh mục
 *     tags: [Categories]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               Name: { type: string }
 *             required: [Name]
 *     responses:
 *       200:
 *         description: Tạo thành công
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data: { $ref: "#/components/schemas/Category" }
 *                 message: { type: string }
 *       500:
 *         description: Lỗi máy chủ
 */

// ...existing code...