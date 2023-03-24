const express = require("express");
const router = express.Router();
const {
  routeRegistration,
  allRoutes,
  routesDelete,
  updateRoute
} = require("../Controllers/route_controller");

router.post("/register", routeRegistration);
router.get("/all", allRoutes);
router.delete("/details/delete/:id", routesDelete);
router.put("/details/update/:id", updateRoute);

module.exports = router;




