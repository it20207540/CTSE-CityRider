import 'package:driver_app/Screens/QRScanner.dart';
import 'package:driver_app/Screens/profile.dart';
import 'package:driver_app/Screens/addRoutes.dart';
import 'package:driver_app/Screens/start_trip_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? myController;

  late Set<Circle> _circles = {
    Circle(
      circleId: CircleId(
        'myCircle',
      ),
      center: LatLng(currentLocation!.latitude!,
          currentLocation!.longitude!),
      radius: 75,
      fillColor: Colors.blue.withOpacity(.25),
      strokeColor: Colors.blueAccent,
      strokeWidth: 2,
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }
  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
        setState(() {});
      },
    );
    location.onLocationChanged.listen(
      (newLocation) {
        currentLocation = newLocation;
        setState(() {});
      },
    );
  }
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          color: Color(0xffffffff),
         
         
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/logo.png',
                          height: 45.0, width: 70.0, fit: BoxFit.cover),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Profile()));
                        },
                        child: Image.asset('images/man.png',
                            height: 38.0, width: 38.0, fit: BoxFit.cover),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "All Actions",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddRoutes()));
                        },
                        child: Container(
                          height: 100.0,
                          width: size.width / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0x93e7e7e7),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/buss.png',
                                  height: 45.0, width: 45.0, fit: BoxFit.cover),
                              SizedBox(
                                height: 7.0,
                              ),
                              Text(
                                "Routes",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                        ),
                      ),
                     
                     
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartTrip()));
                        },
                         child: Container(
                          height: 100.0,
                          width: size.width / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0x93e7e7e7),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.qr_code,size: 40.0,),
                              // Image.asset('images/qr-code.png',
                              //     height: 32.0, width: 32.0, fit: BoxFit.cover),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),

                  //new
                  SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartTrip()));
                        },
                        child: Container(
                          height: 100.0,
                          width: size.width / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0x93e7e7e7),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/user.png',
                                  height: 45.0, width: 45.0, fit: BoxFit.cover),
                              SizedBox(
                                height: 7.0,
                              ),
                              Text(
                                "Passenger Details",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartTrip()));
                        },
                        child: Container(
                          height: 100.0,
                          width: size.width / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0x93e7e7e7),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/bus.png',
                                  height: 45.0, width: 45.0, fit: BoxFit.cover),
                              SizedBox(
                                height: 7.0,
                              ),
                              Text(
                                "Buses",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                        ),
                      ),
                      
                    ],
                  ),
                  
                  SizedBox(
                    height: 25.0,
                  ),
                  
                  SizedBox(
                    height: 25.0,
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
