const express = require("express");
const router = express.Router();
const {
  routeRegistration,
  allRoutes,
} = require("../Controllers/route_controller");

router.post("/register", routeRegistration);
router.get("/all", allRoutes);

module.exports = router;
