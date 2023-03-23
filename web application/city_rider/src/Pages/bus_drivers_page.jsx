import React from "react";
import NavBar from "../Components/nav_bar";
import "../Css/main.css";
import "../Css/drivers_page.css";
import AddIcon from "@mui/icons-material/Add";
import Bus from "../Components/bus";
import CloseIcon from "@mui/icons-material/Close";
import axios from "axios";

function BusDriver() {
  const [isActive, setIsActive] = React.useState(true);

  const [name, setName] = React.useState("");
  const [nic, setNic] = React.useState("");
  const [contact, setContact] = React.useState("");
  const [routeNo, setBusRouteNo] = React.useState("");
  const [route, setBusRoute] = React.useState("");
  const [password, setPassword] = React.useState("");
  const[busNo,setBusNo]=React.useState("")

  const [details, setDetails] = React.useState([]);
  
  const [driverDetails, setDriverDetails] = React.useState({});
  const [driverNic, setDriverNic] = React.useState("");

  React.useEffect(() => {
    axios
      .get("http://localhost:3000/driver/all")
      .then((res) => {
        if (res.data.status === true) {
          setDetails(res.data.drivers);
        } else {
          alert(res.data.message);
        }
      })
      .catch((e) => {
        alert("Something went wrong");
        console.log(e);
      });
  }, []);

  const submitHandler = () => {
    if (name.trim().length === 0) {
      alert("Driver's name required");
    } else if (nic.trim().length === 0) {
      alert("Driver's NIC required");
    } else if (contact.trim().length === 0) {
      alert("Driver's contact no required");
    } else if (contact.trim().length !== 10) {
      alert("Driver's contact no invalid");
    } else if (busNo.trim().length === 0) {
      alert("Bus no required");
    } else if (routeNo.trim().length === 0) {
      alert("Route no required");
    } else if (route.trim().length === 0) {
      alert("Bus Route required");
    } else if (password.trim().length === 0) {
      alert("Password required");
    } else {
      const data = {
        name,
        nic,
        contact,
        routeNo,
        route,
        password,
        busNo,
      };
      axios
        .post("http://localhost:3000/driver/register", data)
        .then((res) => {
          if (res.data.status === true) {
            alert(res.data.message);
            setTimeout(() => {
              setIsActive(!isActive);
            }, 1000);
          } else {
            alert(res.data.message);
          }
        })
        .catch((e) => {
          alert("Something went wrong");
        });
    }
  };

  const formHandler = () => {
    setIsActive(!isActive);
  };

  function getDriverData(nic) {
    setDriverNic(nic);
    axios
      .get(`http://localhost:3000/driver/details/${nic}`)
      .then((res) => {
        if (res.data.status === true) {
          setDriverDetails(res.data.driver);
        } else {
          alert(res.data.message);
        }
      })
      .catch((e) => {
        alert("Something went wrong");
      });
  }

  return (
    <div className="main-container">
      <div className="nav-bar-wrapper">
        <NavBar />
      </div>
      <div className="body-wrapper">
        {isActive ? (
          <div className="driver-container">
            <div className="driver-topic-wrapper">
              <h3>Bus Drivers</h3>
              <AddIcon className="driver-create-icon" onClick={formHandler} />
            </div>
            <div className="driver-search-wrapper">
              <input
                type="search"
                placeholder="Search bus driver"
                className="driver-search-box"
              />
            </div>
            <div className="driver-details-wrapper  ">
              {details.map((detail, index) => (
                <Bus
                  no={detail.busNo}
                  name={detail.name}
                  nic={detail.nic}
                  getDriverData={getDriverData}
                />
              ))}
            </div>
          </div>
        ) : (
          <div className="driver-container">
            <div className="driver-topic-wrapper">
              <h3>Bus Driver Registration</h3>
              <CloseIcon className="driver-create-icon" onClick={formHandler} />
            </div>
            <div className="driver-form-container">
              <div className="driver-input-container">
                <label className="driver-label">Driver's Name</label>
                <input
                  type="text"
                  className="driver-input"
                  onChange={(e) => {
                    setName(e.target.value);
                  }}
                />
              </div>
              <div className="driver-input-container">
                <label className="driver-label">Driver's NIC</label>
                <input
                  type="text"
                  className="driver-input"
                  onChange={(e) => {
                    setNic(e.target.value);
                  }}
                />
              </div>
              <div className="driver-input-container">
                <label className="driver-label">Driver's Contact</label>
                <input
                  type="text"
                  className="driver-input"
                  onChange={(e) => {
                    setContact(e.target.value);
                  }}
                />
              </div>
              <div className="driver-input-container">
                <label className="driver-label">Bus No</label>
                <input
                  type="text"
                  className="driver-input"
                  onChange={(e) => {
                    setBusNo(e.target.value);
                  }}
                />
              </div>
              <div className="driver-input-container">
                <label className="driver-label">Bus Route No</label>
                <input
                  type="test"
                  className="driver-input"
                  onChange={(e) => {
                    setBusRouteNo(e.target.value);
                  }}
                />
              </div>
              <div className="driver-input-container">
                <label className="driver-label">Bus Route Name</label>
                <input
                  type="text"
                  className="driver-input"
                  onChange={(e) => {
                    setBusRoute(e.target.value);
                  }}
                />
              </div>
              <div className="driver-input-container">
                <label className="driver-label">Password</label>
                <input
                  type="password"
                  className="driver-input"
                  onChange={(e) => {
                    setPassword(e.target.value);
                  }}
                />
              </div>
              <div className="driver-btn-container">
                <button className="reg-btn" onClick={submitHandler}>
                  Register
                </button>
              </div>
            </div>
          </div>
        )}
        {driverNic ? (
          <div className="driver-detail-wrapper">
            <h3>Drivers's Personal Details</h3>
            <br />
            <div className="driver-detail-input-wrapper">
              <label className="driver-detail-label-box">Drivers's ID</label>
              <input
                type="text"
                readOnly
                value={driverDetails._id}
                className="driver-detail-display-box"
              />
            </div>
            <div className="driver-detail-input-wrapper">
              <label className="driver-detail-label-box">Drivers's Name</label>
              <input
                type="text"
                readOnly
                value={driverDetails.name}
                className="driver-detail-display-box"
              />
            </div>
            <div className="driver-detail-input-wrapper">
              <label className="driver-detail-label-box">
                Drivers's Contact No
              </label>
              <input
                type="text"
                readOnly
                value={driverDetails.contact}
                className="driver-detail-display-box"
              />
            </div>
            <div className="driver-detail-input-wrapper">
              <label className="driver-detail-label-box">Drivers's NIC</label>
              <input
                type="text"
                readOnly
                value={driverDetails.nic}
                className="driver-detail-display-box"
              />
            </div>
            <div className="driver-detail-input-wrapper">
              <label className="driver-detail-label-box">
                Bus Registration No
              </label>
              <input
                type="text"
                readOnly
                value={driverDetails.busNo}
                className="driver-detail-display-box"
              />
            </div>
            <div className="driver-detail-input-wrapper">
              <label className="driver-detail-label-box">Bus Route No</label>
              <input
                type="text"
                readOnly
                value={driverDetails.routeNo}
                className="driver-detail-display-box"
              />
            </div>
            <div className="driver-detail-input-wrapper">
              <label className="driver-detail-label-box">Bus Route</label>
              <input
                type="text"
                readOnly
                value={driverDetails.route}
                className="driver-detail-display-box"
              />
            </div>
            <div className="driver-detail-input-wrapper">
              <label className="driver-detail-label-box">Password</label>
              <input
                type="text"
                readOnly
                value={driverDetails.password}
                className="driver-detail-display-box"
              />
            </div>
            <br />
          </div>
        ) : (
          <div style={{ width: "78%", height: "100vh", position: "relative" }}>
            <div
              style={{
                width: "300px",
                height: "50px",
                margin: "auto",
                top: "0",
                bottom: "0",
                left: "0",
                right: "0",
                position: "absolute",
              }}
            >
              <h3>Welcome back, Admin</h3>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default BusDriver;
