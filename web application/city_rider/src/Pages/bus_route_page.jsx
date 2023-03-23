import React from "react";
import NavBar from "../Components/nav_bar";
import "../Css/main.css";
import "../Css/route_page.css";
import AddIcon from "@mui/icons-material/Add";
import Route from "../Components/route";
import CloseIcon from "@mui/icons-material/Close";
import axios from "axios";

function BusRoutePage() {
  const [isActive, setIsActive] = React.useState(true);
  const [details, setDetails] = React.useState([]);
  const [routeNo, setRouteNo] = React.useState("");
  const [routeName, setRouteName] = React.useState("");

  React.useEffect(() => {
    axios
      .get("http://localhost:3000/route/all")
      .then((res) => {
        if (res.data.status === true) {
          setDetails(res.data.route);
          console.log(res.data.route);
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
    if (routeNo.trim().length === 0) {
      alert("Bus route no required");
    } else if (routeName.trim().length === 0) {
      alert("Bus route name required");
    } else {
      const data = {
        routeNo,
        routeName,
      };

      axios
        .post("http://localhost:3000/route/register", data)
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
          console.log(e);
        });
    }
  };

  const formHandler = () => {
    setIsActive(!isActive);
  };
  return (
    <div className="main-container">
      <div className="nav-bar-wrapper">
        <NavBar />
      </div>
      <div className="body-wrapper">
        {isActive ? (
          <div className="routes-container">
            <div className="routes-topic-wrapper">
              <h3>Bus Routes</h3>
              <AddIcon className="routes-create-icon" onClick={formHandler} />
            </div>
            <div className="routes-search-wrapper">
              <input
                type="search"
                placeholder="Search bus route"
                className="routes-search-box"
              />
            </div>
            <div className="routes-details-wrapper  ">
              {details.map((detail, index) => (
                <Route
                  route={detail.routeNo}
                  name={detail.routeName}
                  key={index}
                />
              ))}
            </div>
          </div>
        ) : (
          <div className="routes-container">
            <div className="routes-topic-wrapper">
              <h3>Bus Route Registration</h3>
              <CloseIcon className="routes-create-icon" onClick={formHandler} />
            </div>
            <div className="routes-form-container">
              <div className="driver-input-container">
                <label className="driver-label">Bus Route No</label>
                <input
                  type="text"
                  className="driver-input"
                  onChange={(e) => {
                    setRouteNo(e.target.value);
                  }}
                />
              </div>
              <div className="driver-input-container">
                <label className="driver-label">Bus Route Name</label>
                <input
                  type="text"
                  className="driver-input"
                  onChange={(e) => {
                    setRouteName(e.target.value);
                  }}
                />
              </div>

              <div className="routes-btn-container">
                <button className="reg-btn" onClick={submitHandler}>
                  Register
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default BusRoutePage;
