import React from "react";
import "../Css/bus.css";

function Bus(props) {

  return (
    <div
      className="bus-container"
      onClick={() => {
        props.getDriverData(props.nic);
      }}
    >
      <label className="bus-no">{props.no}</label>
      <br />
      <label className="bus-name">{props.name}</label>
    </div>
  );
}

export default Bus;
