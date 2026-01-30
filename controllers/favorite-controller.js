const Favorite = require("../model/favorite");

const CreateFavorite = async (req, res) => {
  try {
    const { products } = req.body; // Đổi từ products sang productId
    const userId = req.user.userId;

    // Kiểm tra sản phẩm đã tồn tại trong favorites chưa
    const existed = await Favorite.findOne({
      user: userId,
      products: products,
    });

    if (existed) {
      return res.status(400).json({
        message: "Sản phẩm đã có trong danh sách yêu thích",
      });
    }

    const favorite = await Favorite.create({
      user: userId,
      products: products,
    });

    // Populate để trả về thông tin đầy đủ của product
    const populatedFavorite = await Favorite.findById(favorite._id).populate('products');

    res.status(201).json({
      message: "Đã thêm vào yêu thích",
      data: populatedFavorite,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const getFavorites = async (req, res) => {
  try {
    const userId = req.user.userId;

    const favorites = await Favorite.find({ user: userId }).populate("products");

    res.json({
      count: favorites.length,
      data: favorites,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const DeleteFavorite = async (req, res) => {
  try {
    const userId = req.user.userId;
    const productId = req.params.products; 

  
    const deleted = await Favorite.findOneAndDelete({
      user: userId,
      products: productId, // Đã là productId rồi, không cần .id
    });

    if (!deleted) {
      return res.status(404).json({
        success: false,
        message: "Sản phẩm không tồn tại trong yêu thích",
      });
    }

    // Lấy lại danh sách favorites sau khi xóa
    const favorites = await Favorite.find({ user: userId }).populate("products");
    
    return res.status(200).json({
      success: true,
      data: favorites,
      count: favorites.length,
      message: "Đã xóa sản phẩm khỏi danh sách yêu thích",
    });
  } catch (error) {
    console.error("Error in DeleteFavorite:", error);
    return res.status(500).json({
      success: false,
      message: "Có lỗi xảy ra khi xóa sản phẩm yêu thích",
      error: error.message,
    });
  }
};

module.exports = { CreateFavorite, getFavorites, DeleteFavorite };