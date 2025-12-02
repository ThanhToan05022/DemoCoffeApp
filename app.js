const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

const swaggerUi = require("swagger-ui-express");
const { swaggerSpec } = require("./config/swagger");
require("dotenv").config();

const connectToDB = require("./config/db");
connectToDB();

const authRouter = require("./routers/auth-routers");
const productsRouter = require("./routers/products-routers");
const categoryRouter = require("./routers/category-routers");
const cartRouter = require("./routers/cart-routers");

const cors = require("cors");
const path = require("path");

app.use(
  cors({
    allowedHeaders: "Content-Type,Authorization",
    methods: "GET,POST,PUT,DELETE",
    origin: "*",
  })
);
app.use(express.json());

app.use("/uploads", express.static("uploads"));
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));
app.get("/swagger.json", (req, res) => res.json(swaggerSpec));

app.use("/api", authRouter);
app.use("/api", productsRouter);
app.use("/api", categoryRouter);
app.use("/api", cartRouter);
app.listen(PORT, () => {
  console.log(`Server is now running in the PORT ${PORT}`);
});
