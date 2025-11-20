const Category = require("../model/Category");
const Products = require("../model/products");

const createProducts = async (req, res) => {
  try {
    const { Name, Price, Description, Category, Size, Rating } = req.body;
    const imageUrl = req.file ? req.file.filename : null;
    if (!Name || !Price || !Description || !Category) {
      return res.status(400).json({
        message:
          "Name and price and description and Category and imageUrl are required",
      });
    }
    
    const products = await Products.create({
      Name,
      Price,
      Description,
      Category,
      Size,
      Rating,
      imageUrl,
    });
    return res.status(200).json({
      success: true,
      data: products,
      message: "Add Products Successfully",
    });
  } catch (error) {
    console.error("❌ Error creating product:", error);

    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const getAllProducts = async (req, res) => {
  try {
    const products = await Products.find().populate("Category");
    return res.status(200).json({
      success: true,
      data: products,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const getNameProductsByCategory = async (req, res) => {
  try {
    const { categoryName } = req.params;
    const category = await Category.findOne({
      Name: { $regex: categoryName, $options: "i" },
    });
    if (!category) {
      return res
        .status(404)
        .json({ success: false, message: "Category not found" });
    }
    const products = await Products.find({ Category: category._id }).populate(
      "Category"
    );

    if (products.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No products found for this category",
      });
    }
    res.status(200).json({
      success: true,
      data: products,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const findProductsByName = async (req, res) => {
  try {
    const { Name } = req.query;
    if (!Name) {
      return res.status(400).json({
        success: false,
        message: "Please provide a name to search.",
      });
    }

    const products = await Products.find({
      Name: {
        $regex: Name,
        $options: "i",
      },
    });
    res.status(200).json({
      success: true,
      count: products.length,
      data: products,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const getDetailsProducts = async (req, res) => {
  try {
    const getDetails = await Products.findById(req.params.id).populate(
      "Category"
    );
    if (!getDetails) {
      return res.status(400).json({
        success: false,
        message: "Products not found",
      });
    }
    return res.status(200).json({
      success: true,
      data: getDetails,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

module.exports = {
  createProducts,
  getAllProducts,
  getNameProductsByCategory,
  findProductsByName,
  getDetailsProducts,
};
