import React from "react";
import "../Css/passenger.css";

function PassengerDetail(props) {
  
  return (
    <div className="passenger-detail-container" onClick={()=>{props.getUserData(props.nic);}}>
      <label className="passenger-nic">{props.nic}</label>
      <br />
      <label className="passenger-name">{props.first} {props.last}</label>
    </div>
  );
}

export default PassengerDetail;
