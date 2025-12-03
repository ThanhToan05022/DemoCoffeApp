require("dotenv").config();
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

const cors = require("cors");
const path = require("path");

const { swaggerSpec, setupSwagger } = require("./config/swagger");

const authRouter = require("./routers/auth-routers");
const productsRouter = require("./routers/products-routers");
const categoryRouter = require("./routers/category-routers");
const cartRouter = require("./routers/cart-routers");

const connectToDB = require("./config/db");
connectToDB();

app.use(
  cors({
    allowedHeaders: ["Content-Type,Authorization"],
    methods: ["GET,POST,PUT,DELETE"],
    origin: "*",
  })
);
app.use(express.json());

app.use("/uploads", express.static(path.join(__dirname, "uploads")));
setupSwagger(app);

app.use("/api", authRouter);
app.use("/api", productsRouter);
app.use("/api", categoryRouter);
app.use("/api", cartRouter);

if (require.main === module) {
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server is now running on PORT ${PORT}`);
  });
}

module.exports = app;