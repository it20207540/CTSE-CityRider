const mongoose = require("mongoose");

const routeSchema = new mongoose.Schema({
  routeNo: {
    type: String,
    required: true,
  },
  routeName: {
    type: String,
    required: true,
  },
   
});

const Route = new mongoose.model("route", routeSchema);

module.exports = Route;
