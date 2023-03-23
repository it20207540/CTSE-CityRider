import React from "react";
import NavBar from "../Components/nav_bar";
import "../Css/main.css";
import "../Css/passengers_page.css";
import AddIcon from "@mui/icons-material/Add";
import PassengerDetail from "../Components/passenger";
import CloseIcon from "@mui/icons-material/Close";
import axios from "axios";

import QRCode from "react-qr-code";

function Passenger() {
  const [isActive, setIsActive] = React.useState(true);

  const [firstName, setFirstName] = React.useState("");
  const [lastName, setLastName] = React.useState("");
  const [email, setEmail] = React.useState("");
  const [contact, setContact] = React.useState("");
  const [nic, setNic] = React.useState("");
  const [password, setPassword] = React.useState("");
  const [details, setDetails] = React.useState([]);

  const [userDetails, setUserDetails] = React.useState({});
  const [qrDetails, setQrDetails] = React.useState({});
  const [userNic, setUserNic] = React.useState("");
  const [qr, setQr] = React.useState("");

  React.useEffect(() => {
    axios
      .get("http://localhost:3000/passenger/all")
      .then((res) => {
        if (res.data.status === true) {
          setDetails(res.data.passengers);
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
    if (firstName.trim().length === 0) {
      alert("First name required");
    } else if (lastName.trim().length === 0) {
      alert("Last name required");
    } else if (email.trim().length === 0) {
      alert("Email address required");
    } else if (nic.trim().length === 0) {
      alert("NIC no required");
    } else if (contact.trim().length === 0) {
      alert("Contact no required");
    } else if (contact.trim().length !== 10) {
      alert("Contact no invalid");
    } else if (password.trim().length === 0) {
      alert("Password required");
    } else {
      const data = {
        firstName,
        lastName,
        email,
        nic,
        contact,
        password,
      };
      axios
        .post("http://localhost:3000/passenger/register", data)
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

  function createQR(nic, bal) {
    let text1 = nic;
    let text2 = bal;
    let result = text1.concat("/", text2);
    return result;
  }

  async function getUserData(nic) {
    setUserNic(nic);
    axios
      .get(`http://localhost:3000/passenger/details/${nic}`)
      .then((res) => {
        if (res.data.status === true) {
          setUserDetails(res.data.user);
        } else {
          alert(res.data.message);
        }
      })
      .catch((e) => {
        alert("Something went wrong");
      });

    axios
      .get(`http://localhost:3000/qr-code/details/${nic}`)
      .then((res) => {
        if (res.data.status === true) {
          setQrDetails(res.data.details);
          let code = createQR(nic, res.data.details.balance);
          setQr(code);
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
          <div className="passenger-container">
            <div className="passenger-topic-wrapper">
              <h3>Passengers</h3>
              <AddIcon
                className="passenger-create-icon"
                onClick={formHandler}
              />
            </div>
            <div className="passenger-search-wrapper">
              <input
                type="search"
                placeholder="Search passengers"
                className="passenger-search-box"
              />
            </div>
            <div className="passenger-details-wrapper  ">
              {details.map((detail, index) => (
                <PassengerDetail
                  first={detail.firstName}
                  last={detail.lastName}
                  id={detail._id}
                  nic={detail.nic}
                  getUserData={getUserData}
                />
              ))}
            </div>
          </div>
        ) : (
          <div className="passenger-container">
            <div className="passenger-topic-wrapper">
              <h3>Passenger</h3>
              <CloseIcon
                className="passenger-create-icon"
                onClick={formHandler}
              />
            </div>
            <div className="passenger-form-container">
              <div className="passenger-input-container">
                <label className="passenger-label">
                  Passenger's First Name
                </label>
                <input
                  type="text"
                  onChange={(e) => {
                    setFirstName(e.target.value);
                  }}
                  className="passenger-input"
                />
              </div>
              <div className="passenger-input-container">
                <label className="passenger-label">Passenger's Last Name</label>
                <input
                  type="text"
                  className="passenger-input"
                  onChange={(e) => {
                    setLastName(e.target.value);
                  }}
                />
              </div>
              <div className="passenger-input-container">
                <label className="passenger-label">Passenger's Email</label>
                <input
                  type="email"
                  className="passenger-input"
                  onChange={(e) => {
                    setEmail(e.target.value);
                  }}
                />
              </div>
              <div className="passenger-input-container">
                <label className="passenger-label">Passenger's NIC</label>
                <input
                  type="text"
                  className="passenger-input"
                  onChange={(e) => {
                    setNic(e.target.value);
                  }}
                />
              </div>
              <div className="passenger-input-container">
                <label className="passenger-label">Passenger's Contact</label>
                <input
                  type="text"
                  className="passenger-input"
                  onChange={(e) => {
                    setContact(e.target.value);
                  }}
                />
              </div>
              <div className="passenger-input-container">
                <label className="passenger-label">Passenger's Password</label>
                <input
                  type="password"
                  className="passenger-input"
                  onChange={(e) => {
                    setPassword(e.target.value);
                  }}
                />
              </div>
              <div className="passenger-btn-container">
                <button className="reg-btn" onClick={submitHandler}>
                  Register
                </button>
              </div>
            </div>
          </div>
        )}
        {userNic ? (
          <div className="passenger-detail-wrapper">
            <h3>Passenger's Personal Details</h3>
            <br />
            <div className="passenger-detail-input-wrapper">
              <label className="passenger-detail-label-box">
                Passenger's ID
              </label>
              <input
                type="text"
                readOnly
                value={userDetails._id}
                className="passenger-detail-display-box"
              />
            </div>
            <div className="passenger-detail-input-wrapper">
              <label className="passenger-detail-label-box">
                Passenger's Name
              </label>
              <input
                type="text"
                readOnly
                value={userDetails.firstName + " " + userDetails.lastName}
                className="passenger-detail-display-box"
              />
            </div>
            <div className="passenger-detail-input-wrapper">
              <label className="passenger-detail-label-box">
                Passenger's Email
              </label>
              <input
                type="text"
                readOnly
                value={userDetails.email}
                className="passenger-detail-display-box"
              />
            </div>
            <div className="passenger-detail-input-wrapper">
              <label className="passenger-detail-label-box">
                Passenger's NIC
              </label>
              <input
                type="text"
                readOnly
                value={userDetails.nic}
                className="passenger-detail-display-box"
              />
            </div>
            <div className="passenger-detail-input-wrapper">
              <label className="passenger-detail-label-box">
                Passenger's Contact
              </label>
              <input
                type="text"
                readOnly
                value={userDetails.contact}
                className="passenger-detail-display-box"
              />
            </div>
            <br />
            <br />
            <h3>Passenger's Trip History</h3>
            <br />
            <div className="passenger-detail-input-wrapper">
              <label className="passenger-detail-label-box">
                Passenger's Credit Balance
              </label>
              <input
                type="text"
                readOnly
                // value={qr}
                value={qrDetails.balance}
                className="passenger-detail-display-box"
              />
            </div>
            <div className="passenger-detail-input-wrapper">
              <label className="passenger-detail-label-box">
                Passenger's QR Code
              </label>
              <div className="passenger-qr-code-display-box">
                <QRCode
                  size={256}
                  style={{ height: "auto", maxWidth: "100%", width: "25%" }}
                  value={qr}
                  viewBox={`0 0 256 256`}
                />
              </div>
            </div>
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

export default Passenger;
