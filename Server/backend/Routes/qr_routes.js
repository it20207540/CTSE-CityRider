const express = require("express");
const router = express.Router();
const {
  QrRegistration,
  QRdetails,
} = require("../Controllers/qr_code_controller");

router.post("/save", QrRegistration);
router.get("/details/:nic", QRdetails);

module.exports = router;
