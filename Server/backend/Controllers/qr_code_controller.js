const QR = require("../Models/qr_code");

//Route registration
const register = (req, res) => {
  const { nic, balance } = req.body;

  QR.findOne({ nic: { $eq: nic } })
    .then((data) => {
      if (!data) {
        const qr = new QR({
          nic: nic,
          balance: parseFloat(balance),
        });
        qr.save()
          .then((data) => {
            if (!data) {
              res.json({ status: false, message: "Registration failed!" });
            } else {
              res.json({
                status: true,
                message: "Details saved successfully!",
              });
            }
          })
          .catch((err) => {
            res.json({ status: false, message: "Something went wrong" });
          });
      } else {
        let bal = data.balance;
        let newBal = parseFloat(bal) + parseFloat(balance);
        QR.updateOne(
          { nic: nic },
          {
            $set: { balance: parseFloat(newBal)},
          }
        )
          .then((data) => {
            if (!data) {
              res.json({ status: false, message: "Recharge failed!" });
            } else {
              res.json({
                status: true,
                message: "Recharged successfully!",
              });
            }
          })
          .catch((err) => {
            res.json({ status: false, message: "Something went wrong" });
          });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

const qr = (req, res) => {
  const nic = req.params.nic;
  QR.findOne({ nic: { $eq: nic } })
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "QR code details invalid." });
      } else {
        res.json({ status: true, details: data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

module.exports = {
  QrRegistration: register,
  QRdetails: qr,
};
