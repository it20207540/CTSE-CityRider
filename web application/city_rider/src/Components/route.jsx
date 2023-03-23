import React from 'react'
import "../Css/route.css";

function Route(props) {
  return (
    <div className="route-container">
      <label className="route-no">{props.route}</label>
      <br />
      <label className="route-name">{ props.name}</label>
    </div>
  );
}

export default Route