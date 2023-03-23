import "./App.css";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import LoginPage from "./Pages/login_page";
// import HomePage from "./Pages/home_page";
import BusDriver from "./Pages/bus_drivers_page";
import BusRoutePage from "./Pages/bus_route_page";
import Passenger from "./Pages/passenger_page";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LoginPage />} />
        {/* <Route path="/home" element={<HomePage />} /> */}
        <Route path="/route" element={<BusRoutePage />} />
        <Route path="/driver" element={<BusDriver />} />
        <Route path="/passenger" element={<Passenger />} />
      </Routes>
    </Router>
  );
}

export default App;
