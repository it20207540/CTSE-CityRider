const express = require("express");
const router = express.Router();
const { adminLogin } = require("../Controllers/admin_controller");

router.get("/login/:username/:password", adminLogin);

module.exports = router;
