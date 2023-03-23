const Passenger = require("../Models/passenger");
const nodemailer = require("nodemailer");
var Code;

//Passenger registration
const register = (req, res) => {
  const { firstName, lastName, email, nic, contact, password } = req.body;
  const passenger = new Passenger({
    firstName: firstName,
    lastName: lastName,
    email: email,
    nic: nic,
    contact: contact,
    password: password,
  });
  passenger
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

const code = (req, res) => {
  let email = req.params.email;
  console.log(email);

  function generateCodeNumber() {
    Code = Math.floor(Math.random() * 1000000) + 1;
  }

  function resetCode() {
    setTimeout(() => {
      Code = 0;
    }, 65000);
  }

  async function generateEmail() {
    generateCodeNumber();

    const emailService = nodemailer.createTransport({
      service: "outlook",

      auth: {
        user: "noreplycert@caddcentre.lk",
        pass: "Cadd@2022#",
      },
    });
    const sender = {
      from: "City Rider Team <noreplycert@caddcentre.lk>",
      to: email,
      subject: "City Rider Verification Code",
      // html: `<h3>Your verification code.</h3>${Code}`,
      text: `Your code is ${Code}`,
    };
    emailService.sendMail(sender, function (error, info) {
      if (error) {
        res.json({
          status: false,
          message: "Something went wrong!",
        });
        console.log(error);
      } else {
        resetCode();
        res.json({
          status: true,
          message: "Your code has been sent to your email address!",
          code: Code,
        });
      }
    });
  }

  generateEmail();
};

//Passenger login
const login = (req, res) => {
  const email = req.params.email;
  const password = req.params.password;
  Passenger.findOne({
    $and: [{ email: { $eq: email } }, { password: { $eq: password } }],
  })
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Invalid Credentials" });
      } else {
        res.json({ status: true, data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

//Get all passengers
const passengers = (req, res) => {
  Passenger.find()
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Something went wrong!" });
      } else {
        res.json({ status: true, passengers: data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

const user = (req, res) => {
  const nic = req.params.nic;
  Passenger.findOne({ nic: { $eq: nic } })
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "User details invalid." });
      } else {
        res.json({ status: true, user: data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

module.exports = {
  passengerRegistration: register,
  passengerLogin: login,
  allPassengers: passengers,
  getUserData: user,
  getCode: code,
};
