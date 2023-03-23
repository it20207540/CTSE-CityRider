const mongoose = require("mongoose");

const qrcodeSchema = new mongoose.Schema({
  nic: {
    type: String,
    required: true,
  },
  balance: {
    type: Number,
    required: true,
  },
});

const Qrcode = new mongoose.model("qrcode", qrcodeSchema);

module.exports = Qrcode;
