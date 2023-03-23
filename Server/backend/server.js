const express = require("express");
const app = express();
const http = require("http").Server(app);
const io = require("socket.io")(http);
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");
require("dotenv").config(); 
const userData = require("./Functions/updateUserData");
let locationDetails = {};

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());

// //Database Connection URL
const URL = process.env.DB_URL;

// //port Number Assign
const port = process.env.port || 3000;

// //Check the database connection
mongoose
  .connect(URL)
  .then(() => console.log("Database connect successfully!"))
  .catch((err) => console.log(err));

//Driver route
app.use("/driver", require("./Routes/driver_routes"));
//User route
app.use("/passenger", require("./Routes/passenger_router"));
//User route
app.use("/route", require("./Routes/busRoute_routes"));
//Admin route
app.use("/admin", require("./Routes/admin_routes"));
//QR route
app.use("/qr-code", require("./Routes/qr_routes"));
//QR route
app.use("/payment", require("./Routes/payment_routes"));

//Socket initiate
io.on("connection", (socket) => {
  console.log(`user connected: ${socket.id}`);

  // socket.on("sendNewMessage", (data) => {
  //   locationDetails.lat = data.Lat;
  //   locationDetails.lug = data.Lug;
  //   const newData = userData.UpdateUser(socket.id, data.Lat, data.Lug); 
  //   console.log(newData);
  //   socket.broadcast.emit("receive", newData);
  //   // console.log(locationDetails);
  // });

  socket.on("join_room", (room) => {
    socket.join(room);
    console.log(room);
  });

  socket.on("send_message", (data) => {
    locationDetails.lat = data.Lat;
    locationDetails.lug = data.Lug;
    const newData = userData.UpdateUser(socket.id, data.Lat, data.Lug);

    socket.to(data.room).emit("receive_message", newData);
    console.log(newData);
    
  });

  socket.on("disconnect", (reason) => {
    userData.RemoveUserFromList(socket.id);
    console.log(reason);
  });

  // socket.on("sendNewMessage", (data) => {
  //   socket.emit("receive_message", data);
  //   // console.log(data.room);
  // });
});

 
http.listen(port, () => {
  console.log("Server is up and running PORT:" + http.address().port);
});
