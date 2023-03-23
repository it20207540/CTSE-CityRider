const mongoose = require("mongoose");

const driverSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  nic: {
    type: String,
    required: true,
  },
  busNo: {
    type: String,
    required: true,
  },
  contact: {
    type: String,
    required: true,
  },
  routeNo: {
    type: String,
    required: true,
  },
  route: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
});

const Driver = new mongoose.model("driver", driverSchema);

module.exports = Driver;
