const multer = require("multer");
const path = require("path");
const fs = require("fs");
const multerS3 = require("multer-s3");
const s3 = require("../config/s3");
require("dotenv").config();

const uploadPath = path.join(__dirname, "..", "uploads");
if (!fs.existsSync(uploadPath)) {
  fs.mkdirSync(uploadPath, { recursive: true });
}
// const storage = multer.diskStorage({
//   destination: function (req, file, cb) {
//     cb(null, uploadPath);
//   },
//   filename: function (req, file, cb) {
//     cb(
//       null,
//       file.fieldname + "-" + Date.now() + path.extname(file.originalname)
//     );
//   },
// });
const upload = multer({
  storage: multerS3({
    s3: s3,
    bucket: process.env.AWS_BUCKET_NAME,
    acl: "public-read",
    contentType: multerS3.AUTO_CONTENT_TYPE,
    key: function (req, file, cb) {
      const fileName = `uploads/${Date.now()}-${file.originalname}`;
      cb(null, fileName);
    },
  }),
});

module.exports = upload;
