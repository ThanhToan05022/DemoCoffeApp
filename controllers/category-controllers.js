const Category = require("../model/Category");

const createCategory = async (req, res) => {
  try {
    const dataCategory = new Category({
      Name: req.body.Name,
    });
    await dataCategory.save();
    return res.status(200).json({
      success: true,
      data: dataCategory,
      message: "Add category successfully",
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

const getAllCategory = async (req, res) => {
  try {
    const data = await Category.find({});
    return res.status(200).json({
      success: true,
      data: data,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something error occured!! Please try again!",
    });
  }
};

module.exports = { createCategory, getAllCategory };
