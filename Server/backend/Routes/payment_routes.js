const express = require("express");
const router = express.Router();
const {
  PaymentSave,
  paymentsDetails,
  passengerTripHistory,
} = require("../Controllers/payment_controller");

router.post("/detail/save", PaymentSave);
router.get("/details/:nic", paymentsDetails);
router.get("/trip/history/:nic", passengerTripHistory);

module.exports = router;
