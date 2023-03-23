const Admin = require("../Models/admin");

//admin login
const login = (req, res) => {
  const username = req.params.username;
  const password = req.params.password;
  Admin.findOne({
    $and: [{ username: { $eq: username } }, { password: { $eq: password } }],
  })
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Invalid Credentials" });
      } else {
        res.json({ status: true, data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong!" });
    });
};

module.exports = {
  adminLogin: login,
};
