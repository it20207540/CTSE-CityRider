const express = require("express");
const router = express.Router();
const {
  driverRegistration,
  driverLogin,
  allDrivers,
  getDriverData,
} = require("../Controllers/driver_controller");

router.post("/register", driverRegistration);
router.get("/login/:nic/:password", driverLogin);
router.get("/all", allDrivers);
router.get("/details/:nic", getDriverData);

module.exports = router;