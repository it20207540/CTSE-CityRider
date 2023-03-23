const Route = require("../Models/route");

//Route registration
const register = (req, res) => {
  const { routeNo, routeName } = req.body;

  const route = new Route({
    routeNo: routeNo,
    routeName: routeName,
  });

  route
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

//Get all routes
const routes = (req, res) => {
  Route.find()
    .then((data) => {
      if (!data) {
        res.json({ status: false, message: "Something went wrong!" });
      } else {
        res.json({ status: true, route:data });
      }
    })
    .catch((err) => {
      res.json({ status: false, message: "Something went wrong" });
    });
};

module.exports = {
  routeRegistration: register,
  allRoutes: routes,
};
