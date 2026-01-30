const express = require("express");
const router = express.Router();
const {
  registerUser,
  loginUser,
  getProfile,
  updateProfile,
  logoutUser,
} = require("../controllers/auth-controllers");
const authMiddleware = require("../middleware/auth-middleware");
const upload = require("../middleware/upload-image");

router.post("/register", upload.single("image"), registerUser);
router.post("/login", upload.none(), loginUser);
router.post("/logout", authMiddleware, logoutUser);
router.get("/profile", authMiddleware, getProfile);
router.put("/profile", upload.single("image"), authMiddleware, updateProfile);
module.exports = router;

/**
 * @swagger
 * /api/register:
 *   post:
 *     summary: Đăng ký tài khoản
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               name: { type: string }
 *               email: { type: string, format: email }
 *               password: { type: string, format: password }
 *               image:
 *                 type: string
 *                 format: uri
 *     responses:
 *       200:
 *         description: Đăng ký thành công
 *       400:
 *         description: User đã tồn tại hoặc dữ liệu không hợp lệ
 */

/**
 * @swagger
 * /api/logout:
 *   post:
 *     summary: Đăng xuất người dùng (blacklist token)
 *     tags: [Auth]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Đã đăng xuất thành công hoặc token đã bị blacklist
 *       400:
 *         description: Không có token trong header
 *       500:
 *         description: Lỗi server
 */

/**
 * @swagger
 * /api/login:
 *   post:
 *     summary: Đăng nhập người dùng
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 format: email
 *                 example: user@example.com
 *               password:
 *                 type: string
 *                 format: password
 *
 *     responses:
 *       200:
 *         description: Đăng nhập thành công, trả về user và token
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 user:
 *                   type: object
 *                   properties:
 *                     _id:
 *                       type: string
 *                     name:
 *                       type: string
 *                     email:
 *                       type: string
 *                     avatar:
 *                       type: string
 *                       nullable: true
 *                 message:
 *                   type: string
 *                   example: Login successfully!
 *                 token:
 *                   type: string
 *       400:
 *         description: Sai email hoặc mật khẩu
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: false
 *                 message:
 *                   type: string
 *                   example: invalid credentials
 */

/**
 * @swagger
 * /api/profile:
 *   get:
 *     summary: Lấy thông tin profile người dùng
 *     tags: [Auth]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Trả về hồ sơ người dùng
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success: { type: boolean }
 *                 profile:
 *                   $ref: "#/components/schemas/User"
 *       401:
 *         description: Unauthorized
 */

/**
 * @swagger
 * /api/profile:
 *   put:
 *     summary: Cập nhật profile (tên, mật khẩu, avatar)
 *     tags: [Auth]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: false
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               name: { type: string }
 *               password: { type: string, format: password }
 *               image:
 *                 type: string
 *                 format: uri
 *     responses:
 *       200:
 *         description: Cập nhật thành công
 *       400:
 *         description: User không tồn tại
 *       401:
 *         description: Unauthorized
 */
