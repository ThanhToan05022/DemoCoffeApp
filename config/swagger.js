const swaggerJsDoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");
const cors = require("cors");
const BASE_URL = process.env.BASE_URL || "http://localhost:3000/api";

const options = {
  definition: {
    openapi: "3.0.1",
    info: {
      title: "Coffee App API",
      version: process.env.npm_package_version || "1.0.0",
      description: "Tài liệu OpenAPI cho Coffee App",
      contact: {
        name: "API Support",
      },
    },
    servers: [
      {
        url: BASE_URL,
        description: "Server",
      },
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: "http",
          scheme: "bearer",
          bearerFormat: "JWT",
        },
      },
      schemas: {
        User: {
          type: "object",
          required: ["name", "email", "password"],
          properties: {
            _id: { type: "string", example: "64a1f2e9b3c4d5e6f7a8b9c0" },
            name: { type: "string", example: "Nguyen Van A" },
            email: {
              type: "string",
              format: "email",
              example: "user@example.com",
            },
            password: {
              type: "string",
              format: "password",
              example: "secret123",
            },
            avatar: { type: "string", format: "uri", nullable: true },
          },
        },

        CartItem: {
          type: "object",
          properties: {
            _id: { type: "string" },
            product: {
              type: "string",
              description: "ObjectId of product (Coffee) as string",
            },
            quantity: { type: "integer", example: 1 },
            price: { type: "number", format: "float", example: 120000 },
          },
        },

        Cart: {
          type: "object",
          properties: {
            _id: { type: "string" },
            user: {
              $ref: "#/components/schemas/User",
              description: "Reference to User (ObjectId)",
            },
            totalPrice: { type: "number", format: "float", example: 0 },
            items: {
              type: "array",
              items: { $ref: "#/components/schemas/CartItem" },
              description: "Array of CartItem references (stored as ObjectIds)",
            },
            paymentMethod: { type: "string", example: "card" },
            orderDate: { type: "string", format: "date-time" },
          },
        },

        Product: {
          type: "object",
          required: ["Name", "Price"],
          properties: {
            _id: { type: "string", example: "64a1f2e9b3c4d5e6f7a8b9c0" },
            Name: { type: "string", example: "Cà phê sữa" },
            Price: { type: "number", format: "float", example: 25000 },
            Description: { type: "string", example: "Cà phê rang xay" },
            Category: { type: "string", description: "Category ObjectId" },
            imageUrl: { type: "string", format: "uri", nullable: true },
          },
        },

        Category: {
          type: "object",
          properties: {
            _id: { type: "string" },
            Name: { type: "string", example: "Drinks" },
          },
        },
        Favorite: {
          type: "object",
          properties: {
            _id: { type: "string" },
            user: {
              $ref: "#/components/schemas/User",
              description: "Reference to User (ObjectId)",
            },
            items: {
              type: "array",
              items: { $ref: "#/components/schemas/FavoriteItem" },
              description: "List of favorite product entries",
            },
          },
        },
      },
    },
    security: [],
  },

  // quét JSDoc trong các thư mục đúng với cấu trúc project
  apis: ["./routers/*.js", "./controllers/*.js", "./model/*.js"],
};

const swaggerSpec = swaggerJsDoc(options);

const setupSwagger = (app) => {
  app.use(
    "/api-docs",
    cors(),
    swaggerUi.serve,
    swaggerUi.setup(swaggerSpec, { explorer: true })
  );

  app.get("/swagger.json", cors(), (req, res) => {
    res.setHeader("Content-Type", "application/json");
    res.send(swaggerSpec);
  });
};
module.exports = {
  setupSwagger,
  swaggerSpec,
};
