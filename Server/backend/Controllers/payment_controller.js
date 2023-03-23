const Payment = require("../Models/payment");
const QR = require("../Models/qr_code");

//Route registration
const save = (req, res) => {
  const { passengerNIC, driverNIC, busRouteNo, busRoute, amount } = req.body;

  let today = new Date();
  let dd = String(today.getDate()).padStart(2, "0");
  let mm = String(today.getMonth() + 1).padStart(2, "0");
  let yyyy = today.getFullYear();
  today = mm + "/" + dd + "/" + yyyy;

  const payment = new Payment({
    passengerNIC: passengerNIC,
    driverNIC: driverNIC,
    busRouteNo: busRouteNo,
    busRoute: busRoute,
    amount: parseFloat(amount),
    date: today,
  });

  CallFunction();

  async function GetBalance(userNic) {
    let balance;
    await QR.findOne({ nic: { $eq: userNic } })
      .then((data) => {
        balance = data.balance;
      })
      .catch((err) => {
        console.log(err);
      });
    return balance;
  }

  function SaveData(payments) {
    payments
      .save()
      .then((data) => {
        if (!data) {
          res.json({ status: false, message: "Payment failed!" });
        } else {
          res.json({ status: true, message: "Payment successful!" });
        }
      })
      .catch((err) => {
        res.json({ status: false, message: "Something went wrong" });
      });
  }

  function UpdateBalance(nic, amount, bal) {
    let newBal = bal - amount;
    QR.updateOne(
      { nic: nic },
      {
        $set: { balance: newBal },
      }
    )
      .then((data) => {
        // console.log(data);
      })
      .catch((err) => {
        // console.log(err);
      });
  }

  async function CallFunction() {
    let bal = await GetBalance(passengerNIC);
    if (bal > parseFloat(amount)) {
      SaveData(payment);
      UpdateBalance(passengerNIC, parseFloat(amount), bal);
    } else {
      res.json({ status: false, message: "Insufficient account balance!" });
    }
  }
};


const payments = (req, res) => {
  const nic = req.params.nic;
  Payment.find({ driverNIC: { $eq: nic } })
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Payment details invalid." });
      } else {
        res.json({ status: true, details: data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

const passengerTripHistory = (req, res) => {
  const nic = req.params.nic;
  Payment.find({ passengerNIC: { $eq: nic } })
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "User details invalid." });
      } else {
        res.json({ status: true, details: data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

module.exports = {
  PaymentSave: save,
  paymentsDetails: payments,
  passengerTripHistory: passengerTripHistory,
};
