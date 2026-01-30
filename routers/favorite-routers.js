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
