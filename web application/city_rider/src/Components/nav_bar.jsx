import React from "react";
import "../Css/nav_bar.css";
import Logo from "../images/logo.png";
// import SettingsIcon from "@mui/icons-material/Settings";
// import HomeIcon from "@mui/icons-material/Home";
import AltRouteIcon from "@mui/icons-material/AltRoute";
import DirectionsBusIcon from "@mui/icons-material/DirectionsBus";
import PeopleIcon from "@mui/icons-material/People";
import LogoutIcon from "@mui/icons-material/Logout";
import { NavLink, useNavigate } from "react-router-dom";

function NavBar() {
  const navigate = useNavigate();

  const logOutHandler = () => {
    navigate("/");
  };
  
  return (
    <div className="nav-bar-container clearfix">
      <div className="logo-wrapper  ">
        <img src={Logo} width="60px" alt="logo" />
      </div>
      <div className="action-container">
        {/* <div className="action-button">
          <NavLink to="/home">
            <HomeIcon
              className="icon-button"
              sx={{
                color: "white",
                fontSize: "30px",
              }}
            />
          </NavLink>
        </div> */}

        <div className="action-button">
          <NavLink to="/driver">
            <DirectionsBusIcon
              className="icon-button"
              sx={{
                color: "white",
                fontSize: "30px",
              }}
            />
          </NavLink>
        </div>
        <div className="action-button">
          <NavLink to="/passenger">
            <PeopleIcon
              className="icon-button"
              sx={{
                color: "white",
                fontSize: "30px",
              }}
            />
          </NavLink>
        </div>
        <div className="action-button">
          <NavLink to="/route">
            <AltRouteIcon
              className="icon-button"
              sx={{
                color: "white",
                fontSize: "30px",
              }}
            />
          </NavLink>
        </div>
        {/* <div className="action-button">
          <SettingsIcon
            className="icon-button"
            sx={{
              color: "white",
              fontSize: "30px",
            }}
          />
        </div> */}
      </div>
      <div className="settings-wrapper  ">
        <LogoutIcon
          className="icon-button"
          sx={{
            color: "white",
            fontSize: "30px",
          }}
          onClick={logOutHandler}
        />
      </div>
    </div>
  );
}

export default NavBar;
