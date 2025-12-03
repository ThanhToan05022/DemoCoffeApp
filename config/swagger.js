const swaggerJsDoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");

const BASE_URL = process.env.BASE_URL || "http://localhost:3000";

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

        Products: {
          type: "object",
          properties: {
            _id: { type: "string" },
            name: { type: "string" },
            origin: { type: "string" },
            description: { type: "string" },
            price: { type: "number", format: "float" },
            imageUrl: { type: "string", format: "uri" },
          },
        },

        Category: {
          type: "object",
          properties: {
            _id: { type: "string" },
            name: { type: "string" },
            slug: { type: "string" },
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
    swaggerUi.serve,
    swaggerUi.setup(swaggerSpec, { explorer: true })
  );

  app.get("/swagger.json", (req, res) => {
    res.setHeader("Content-Type", "application/json");
    res.send(swaggerSpec);
  });
};
module.exports = {
  setupSwagger,
  swaggerSpec,
};
