import 'package:driver_app/Component/qr_scan.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Component/ip.dart';

class StartTrip extends StatefulWidget {
  const StartTrip({Key? key}) : super(key: key);
  @override
  State<StartTrip> createState() => _StartTripState();
}

class _StartTripState extends State<StartTrip> {
  GoogleMapController? myController;
  late IO.Socket socket;
  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  bool qrIsOpen = false;
  LocationData? currentLocation;
  bool isTripStart = false;
  String? room;
  String? route;

  // sendMessage(double lat, double lun) {
  //   Map messageMap = {
  //     'Lat': lat,
  //     'Lug': lun,
  //   };
  //   socket.emit('sendNewMessage', messageMap);
  // }

  sendMessage(double lat, double lun, String room) {
    Map messageMap = {'Lat': lat, 'Lug': lun, 'room': room};
    socket.emit('send_message', messageMap);
  }

  joinRoom(String room) {
    socket.emit('join_room', room);
  }

  void shareLocation() async {
    await initSocket();
    await joinRoom(room!);

    isTripStart = true;

    Location location = Location();
    location.onLocationChanged.listen(
      (newLocation) {
        currentLocation = newLocation;
        sendMessage(
            currentLocation!.latitude!, currentLocation!.longitude!,room!);
        setState(() {});
      },
    );
  }

  void endTrip() {
    // isTripStart = false;
    socket.disconnect();
    socket.dispose();
  }

  void getCurrentLocation() async {
    setState(() {});
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        setState(() {});
      },
    );
  }

  initSocket() {
    socket = IO.io('${currentIp}', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      isTripStart = true;
    });
    socket.onDisconnect((_) => {
          // socket.emit("disconnect", "Finished task")
          isTripStart = false
        });
    socket.onConnectError((err) => {isTripStart = false});
    socket.onError((err) => isTripStart = false);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    room = prefs.getString('routeNo');
    route = prefs.getString('route');
  }

  @override
  void initState() {
    getData();
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text(
            'Double tap to exit',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        child: SlidingUpPanel(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: Color(0xd5ffffff),
          minHeight: 28.0,
          maxHeight: 150.0,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: size.width,
                height: size.height,
                child: currentLocation == null
                    ? const Center(
                        child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 30.0,
                      ))
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                            zoom: 12.5),
                        mapType: MapType.normal,
                        markers: {
                          Marker(
                            markerId: MarkerId("Start Point"),
                            position: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                          ),
                        },
                      ),
              ),
              Positioned(
                top: 30.0,
                width: size.width / 1.1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xedffffff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${room==null?"Loading":room}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23.0),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Text(
                                  "${route==null?"Loading":route}",
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w400),
                                ),
                                // SizedBox(
                                //   width: 10.0,
                                // ),
                                // Text(
                                //   "Kiribathgoda",
                                //   style: TextStyle(
                                //       fontSize: 16.5,
                                //       fontWeight: FontWeight.w400),
                                // )
                              ],
                            )
                          ],
                        ),
                        isTripStart == false
                            ? IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.location_off_sharp,
                                    color: Colors.red))
                            : IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.navigation,
                                    color: Colors.green)),
                      ],
                    ),
                  ),
                ),
              ),
              if (qrIsOpen == true)
                Positioned(
                    top: 180.0,
                    width: size.width / 1.1,
                    height: size.height / 1.6,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                      ),
                      child: QrScan(),
                    ))
            ],
          ),
          panel: Container(
            width: size.width,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 9,
                  child: Container(
                    width: 70.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                Positioned(
                  width: size.width,
                  height: 123.0,
                  bottom: 0,
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      isTripStart == false
                          ? ElevatedButton.icon(
                              onPressed: shareLocation,
                              label: Text("Start Trip"),
                              icon: Icon(Icons.navigation),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black87,
                                  fixedSize: Size(size.width / 3, 50)),
                            )
                          : ElevatedButton.icon(
                              onPressed: endTrip,
                              label: Text("End Trip"),
                              icon: Icon(Icons.location_off_sharp),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent,
                                  fixedSize: Size(size.width / 3, 50)),
                            ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            qrIsOpen = !qrIsOpen;
                          });
                        },
                        label: qrIsOpen == false
                            ? Text(
                                "Scan QR",
                                style: TextStyle(color: Colors.black87),
                              )
                            : Text(
                                "Close QR",
                                style: TextStyle(color: Colors.black87),
                              ),
                        icon: Icon(
                          Icons.qr_code_2,
                          color: Colors.black87,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black87,
                            side: BorderSide(color: Colors.black87, width: 2),
                            fixedSize: Size(size.width / 3, 50)),
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
