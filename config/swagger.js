const path = require("path");
const swaggerJsdoc = require("swagger-jsdoc");

const swaggerOptions = {
  definition: {
    openapi: "3.0.0",
    info: { title: "BE Flutter API", version: "1.0.0" },
    servers: [{ url: process.env.BASE_URL || "http://localhost:3000" }],
    components: {
      securitySchemes: {
        bearerAuth: { type: "http", scheme: "bearer", bearerFormat: "JWT" },
      },
      schemas: {
        Category: {
          type: "object",
          properties: {
            _id: { type: "string" },
            Name: { type: "string" },
          },
        },
        Product: {
          type: "object",
          properties: {
            _id: { type: "string", readOnly: true },
            Name: { type: "string" },
            Price: { type: "number" },
            Description: { type: "string" },
            Category: {
              oneOf: [
                { type: "string", description: "Category ObjectId" },
                { $ref: "#/components/schemas/Category" },
              ],
            },
            Size: { type: "string", nullable: true },
            Rating: { type: "number", nullable: true },
            imageUrl: {
              type: "string",
              nullable: true,
              description: "Tên file ảnh đã upload",
            },
            createdAt: { type: "string", format: "date-time", nullable: true },
            updatedAt: { type: "string", format: "date-time", nullable: true },
          },
          required: ["Name", "Price", "Description", "Category"],
        },
        User: {
          type: "object",
          properties: {
            _id: { type: "string" },
            name: { type: "string" },
            email: { type: "string", format: "email" },
            avatar: { type: "string", nullable: true },
            imageUrl: { type: "string", nullable: true, readOnly: true },
          },
        },
        CartItem: {
          type: "object",
          properties: {
            _id: { type: "string" },
            products: {
              oneOf: [
                { type: "string", description: "Products ObjectId" },
                { $ref: "#/components/schemas/Product" }
              ]
            },
            quantity: { type: "integer", minimum: 1 },
            Size: { type: "string", nullable: true },
            price: { type: "number" }
          }
        },
        Cart: {
          type: "object",
          properties: {
            _id: { type: "string" },
            user: { type: "string" },
            items: {
              type: "array",
              items: { $ref: "#/components/schemas/CartItem" }
            },
            totalPrice: { type: "number" },
            createdAt: { type: "string", format: "date-time", nullable: true },
            updatedAt: { type: "string", format: "date-time", nullable: true }
          }
        }
      },
    },
    security: [{ bearerAuth: [] }],
  },
  apis: [
    path.join(__dirname, "../routers/*.js"),
    path.join(__dirname, "../routers/**/*.js"),
    path.join(__dirname, "../controllers/*.js"),
  ],
};

const swaggerSpec = swaggerJsdoc(swaggerOptions);
module.exports = { swaggerSpec };
