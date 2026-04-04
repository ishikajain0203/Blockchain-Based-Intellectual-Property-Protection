const mongoose = require("mongoose");

const ipSchema = new mongoose.Schema({
  ipId: Number,
  owner: String,
  title: String,
  description: String,
  hash: String,
  status: String,
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model("IP", ipSchema);