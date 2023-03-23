var locationData = [];
// tezt
function UpdateUser(userID, lat, lug) {
  if (locationData.find((element) => element.id == userID)) {
    let index = locationData.findIndex((element) => element.id == userID);

    console.log(userID + " " + index);

    locationData[index].lat = lat;
    locationData[index].lug = lug;

    return locationData;
  } else {
    locationData.push({ id: userID, lat: lat, lug: lug });
    return "new user";
  }
}

function RemoveUserFromList(id) {
  let index = locationData.findIndex((element) => element.id == id);
  locationData.splice(index, 1);
}

module.exports = { UpdateUser, RemoveUserFromList };
