import React from "react";
import "../Css/login.css";
import Logo from "../images/logo.png";
import PersonOutlineOutlinedIcon from "@mui/icons-material/PersonOutlineOutlined";
import LockOpenIcon from "@mui/icons-material/LockOpen";
import axios from "axios"; 
import { useNavigate } from "react-router-dom";
import CircularProgress from "@mui/material/CircularProgress";

function LoginPage() {
  const [username, setUsername] = React.useState("")
  const [password, setPassword] = React.useState("");
  const navigate = useNavigate();
  const [isLoad, setIsLoad] = React.useState(false);
  
  const loginHandler = () => {
    if (username.trim().length === 0) {
      alert("Enter your username.")
    }
    else if (password.trim().length === 0) {
      alert("Enter your password.");
    }
    else {
      axios
        .get(`http://localhost:3000/admin/login/${username}/${password}`)
        .then((res) => {
          if (res.data.status === false) {
            alert(res.data.message);
          } else {
            setIsLoad(true)
            setTimeout(() => {
              navigate("/driver");
            },2000)
          }
        })
        .catch((e) => {
          alert("Something went wrong!");
        });
    }
  }
  return (
    <div className="login-container">
      <div className="login-form-container">
        <div className="image-container">
          <div className="image-wrapper">
            <img src={Logo} width="200px" alt="Logo" />
            <h2 className="heading">City Rider</h2>
            <h3 className="greeting">Welcome back, Admin</h3>
          </div>
        </div>
        <div className="input-container">
          <h2>Sign In</h2>
          <br />
          <div className="login-input-wrapper">
            <PersonOutlineOutlinedIcon />
            <input
              type="text"
              className="login-input"
              placeholder="Username"
              onChange={(e) => {
                setUsername(e.target.value);
              }}
            />
          </div>
          <div className="login-input-wrapper">
            <LockOpenIcon />
            <input
              type="password"
              className="login-input"
              placeholder="Password"
              onChange={(e) => {
                setPassword(e.target.value);
              }}
            />
          </div>

          {!isLoad ? (
            <button className="sign-in-btn" onClick={loginHandler}>
              Sign In
            </button>
          ) : (
            <CircularProgress color="inherit" style={{ marginTop: "30px" }} />
          )}
        </div>
      </div>
    </div>
  );
}

export default LoginPage;
