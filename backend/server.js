const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

// MongoDB connection
mongoose.connect("mongodb+srv://ishikasinghvi229_db_user:ishikajain@cluster0.2i3rftj.mongodb.net/chainip")
  .then(() => console.log("✅ MongoDB Atlas Connected"))
  .catch(err => console.error("❌ MongoDB Error:", err));

app.use("/api/ip", require("./routes/ipRoutes"));

app.listen(5000, () => {
  console.log("🚀 Server running on port 5000");
});