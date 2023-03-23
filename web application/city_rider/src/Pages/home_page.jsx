import React from "react";
import NavBar from "../Components/nav_bar";
import "../Css/main.css";

function HomePage() {
  return (
    <div className="main-container">
      <div className="nav-bar-wrapper">
        <NavBar />
      </div>
      <div className="body-wrapper">
        <h1>Home</h1>
      </div>
    </div>
  );
}

export default HomePage;
