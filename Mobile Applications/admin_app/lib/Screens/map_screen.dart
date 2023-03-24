import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
//import 'package:passenger_app/Screens/qr_code_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Component/ip.dart';

class MapScrenn extends StatefulWidget {
  String? routeNo;
  String? routeName;
  MapScrenn({Key? key, this.routeNo, this.routeName}) : super(key: key);

  @override
  State<MapScrenn> createState() => _MapScrennState();
}

class _MapScrennState extends State<MapScrenn> {
  late IO.Socket socket;
  List<Marker> markers = [];
  String? currentLat;
  String? currentLug;
  double? val;
  double? val2;
  LocationData? currentLocation;
  Location location = Location();

  joinRoom(String room) {
    socket.emit('join_room', room);
  }

  getData() {
    socket.on('receive_message', (newMessage) {
      markers.clear();
      setState(() {
        currentLat = newMessage[0]["lat"].toString();
        currentLug = newMessage[0]["lug"].toString();
        val = newMessage[0]["lat"];
        val2 = newMessage[0]["lug"];
        for (int i = 0; i < newMessage.length; i++) {
          markers.add(Marker(
              markerId: MarkerId(newMessage[i]["id"].toString()),
              position: LatLng(newMessage[i]["lat"], newMessage[i]["lug"]),
              infoWindow: InfoWindow(title: "Bus"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen)));
        }
        // markers.add(
        //     Marker(
        //         markerId: MarkerId("10202020"),
        //         position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        //         infoWindow: InfoWindow(title: "Bus"),
        //         icon: BitmapDescriptor.defaultMarkerWithHue(
        //             BitmapDescriptor.hueGreen))
        // );
      });
    });
  }

  getCurrentLocation() {
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    location.onLocationChanged.listen(
      (newLocation) {
        currentLocation = newLocation;
        setState(() {});
      },
    );
  }

  initSocket() {
    socket = IO.io('${'http://20.12.14.145:9000'}', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    initSocket();
    joinRoom(widget.routeNo!);
    getData();
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: markers.isEmpty
                  ? Container(
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: const Center(
                          child: SpinKitThreeBounce(
                        color: Color.fromARGB(255, 14, 13, 13),
                        size: 30.0,
                      )),
                    )
                  : Container(
                      width: size.width,
                      height: size.height,
                      color: Color(0xFF2A2A2A),
                      child: GoogleMap(
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                            // target: LatLng(
                            //     val == null ? currentLocation!.latitude! : val!,
                            //     val2 == null
                            //         ? currentLocation!.longitude!
                            //         : val2!),
                            target: currentLocation == null
                                ? LatLng(6.9587314, 79.9102938)
                                : LatLng(currentLocation!.latitude!,
                                    currentLocation!.longitude!),
                            zoom: 16.0),
                        mapType: MapType.normal,
                        markers: markers.map((e) => e).toSet(),
                      ),
                    )),
          Positioned(
              top: 50.0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xB0070707),
                    borderRadius: BorderRadius.circular(15.0)),
                margin: EdgeInsets.all(20.0),
                width: size.width,
                height: 95.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: size.width / 1.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.routeNo}",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${widget.routeName}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.qr_code,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => QRScreen()));
                      },
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
