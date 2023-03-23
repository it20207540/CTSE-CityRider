const mongoose = require("mongoose");

const paymentSchema = new mongoose.Schema({
  passengerNIC: {
    type: String,
    required: true,
  },
  driverNIC: {
    type: String,
    required: true,
  },
  busRouteNo: {
    type: String,
    required: true,
  },
  busRoute: {
    type: String,
    required: true,
  },
  amount: {
    type: Number,
    required: true,
  },
  date: {
    type: Date,
    required: true,
  },
});

const Payment = new mongoose.model("payment", paymentSchema);

module.exports = Payment;
