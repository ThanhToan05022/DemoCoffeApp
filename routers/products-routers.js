const express = require("express");
const router = express.Router();

const {
  createProducts,
  getAllProducts,
  getNameProductsByCategory,
  findProductsByName,
  getDetailsProducts,
} = require("../controllers/products-controller");
const authMiddleware = require("../middleware/auth-middleware");
const upload = require("../middleware/upload-image");

router.post(
  "/createProducts",
  upload.single("imageUrl"),
  authMiddleware,
  createProducts
);
router.get("/getProducts", authMiddleware, getAllProducts);
router.get(
  "/getProductsByCategory/:categoryName",
  authMiddleware,
  getNameProductsByCategory
);
router.get("/findProducts/search", authMiddleware, findProductsByName);
router.get("/getdetailsProducts/:id", authMiddleware, getDetailsProducts);
module.exports = router;

/**
 * @swagger
 * tags:
 *   - name: Products
 *     description: API sản phẩm
 */

/**
 * @swagger
 * /api/getProducts:
 *   get:
 *     summary: Lấy danh sách sản phẩm
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Danh sách sản phẩm
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data:
 *                   type: array
 *                   items: { $ref: "#/components/schemas/Product" }
 */

/**
 * @swagger
 * /api/createProducts:
 *   post:
 *     summary: Tạo sản phẩm mới
 *     description: Upload ảnh bằng field "imageUrl" (multer), server sẽ lưu tên file vào field imageUrl.
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               Name: { type: string }
 *               Price: { type: number }
 *               Description: { type: string }
 *               Category: { type: string, description: "Category ObjectId" }
 *               Size: { type: string }
 *               Rating: { type: string }
 *               imageUrl:
 *                 type: string
 *                 format: binary
 *     responses:
 *       200:
 *         description: Tạo thành công
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data: { $ref: "#/components/schemas/Product" }
 *                 message: { type: string }
 *       400:
 *         description: Thiếu trường bắt buộc
 */

/**
 * @swagger
 * /api/getdetailsProducts/{id}:
 *   get:
 *     summary: Lấy chi tiết sản phẩm theo ID
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string }
 *     responses:
 *       200:
 *         description: Chi tiết sản phẩm
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data: { $ref: "#/components/schemas/Product" }
 *       400:
 *         description: Không tìm thấy
 */

/**
 * @swagger
 * /api/findProducts/search:
 *   get:
 *     summary: Tìm sản phẩm theo tên (regex, không phân biệt hoa thường)
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: Name
 *         required: true
 *         schema: { type: string }
 *         description: Tên sản phẩm cần tìm
 *     responses:
 *       200:
 *         description: Kết quả tìm kiếm
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 count: { type: integer }
 *                 data:
 *                   type: array
 *                   items: { $ref: "#/components/schemas/Product" }
 *       400:
 *         description: Thiếu tham số Name
 */

/**
 * @swagger
 * /api/getProductsByCategory/{categoryName}:
 *   get:
 *     summary: Lấy sản phẩm theo tên danh mục
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: categoryName
 *         required: true
 *         schema: { type: string }
 *         description: Tên danh mục (khớp regex không phân biệt hoa thường)
 *     responses:
 *       200:
 *         description: Danh sách sản phẩm theo danh mục
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 data:
 *                   type: array
 *                   items: { $ref: "#/components/schemas/Product" }
 *       404:
 *         description: Không tìm thấy danh mục hoặc không có sản phẩm
 */
