const express = require("express");
const router = express.Router();
const IP = require("../models/IP");

// Save IP
router.post("/add", async (req, res) => {
  try {
    const ip = new IP(req.body);
    await ip.save();
    res.json(ip);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get all IPs
router.get("/", async (req, res) => {
  const ips = await IP.find();
  res.json(ips);
});

module.exports = router;