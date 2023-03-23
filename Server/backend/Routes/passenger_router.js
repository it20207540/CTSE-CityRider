const express = require("express");
const router = express.Router();
const {
  passengerRegistration,
  passengerLogin,
  allPassengers,
  getUserData,
  getCode
} = require("../Controllers/passenger_controller");

router.post("/register", passengerRegistration);
router.get("/login/:email/:password", passengerLogin);
router.get("/all", allPassengers);
router.get("/details/:nic", getUserData);
router.get("/verification/code/:email", getCode);

module.exports = router;
