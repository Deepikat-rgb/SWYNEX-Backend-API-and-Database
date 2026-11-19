require("dotenv").config();
const express = require("express");
const cors = require("cors");
const pool = require("./db");
const menuRoutes = require("./routes/menu");
const orderRoutes = require("./routes/orders");

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json({ limit: "100kb" }));

app.get("/api/health", async (req, res, next) => {
  try {
    await pool.query("SELECT 1");
    res.json({ status: "ok", database: "connected", service: "Queueless Canteen API" });
  } catch (err) { next(err); }
});

app.use("/api/menu", menuRoutes);
app.use("/api/orders", orderRoutes);

app.use((req, res) => res.status(404).json({ error: "Route not found" }));

app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: "Internal server error" });
});

app.listen(PORT, () => {
  console.log(`Queueless Canteen API running at http://localhost:${PORT}`);
});
