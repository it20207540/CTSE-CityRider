const Driver = require("../Models/drivers");

//Driver registration
const register = (req, res) => {
  const { name, nic, contact, routeNo, route, password, busNo } = req.body;
  const driver = new Driver({
    name: name,
    nic: nic,
    contact: contact,
    routeNo: routeNo,
    route: route,
    password: password,
    busNo: busNo,
  });
  driver
    .save()
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Registration failed!" });
      } else {
        res.json({ status: true, message: "Registration Done!" });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

//Driver login
const login = (req, res) => {
  const nic = req.params.nic
    const password = req.params.password;
  Driver.findOne({
    $and: [{ nic: { $eq: nic } }, { password: { $eq: password } }],
  })
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Invalid Credentials" });
      } else {
        res.json({ status: true, data });
      }
    })
    .catch((err) => {
      res.json({ status: false, err });
    });
};

//Get all drivers
const drivers = (req, res) => {
  Driver.find()
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Something went wrong!" });
      } else {
        res.json({ status: true, drivers: data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

const driver = (req, res) => {
  const nic = req.params.nic;
  Driver.findOne({ nic: { $eq: nic } })
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Driver details invalid." });
      } else {
        res.json({ status: true, driver: data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

module.exports = {
  driverRegistration: register,
  driverLogin: login,
  allDrivers: drivers,
  getDriverData:driver
};
