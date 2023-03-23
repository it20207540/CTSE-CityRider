import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:passenger_app/Screens/bus_route_screen.dart';
import 'package:passenger_app/Screens/qr_code_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'IP.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List details = [];
  bool isLoad = false;
  String? fname;
  String? lname;


  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nic = prefs.getString('nic');
    fname = prefs.getString('name');
    lname = prefs.getString('lastName');

    var response = await http
        .get(Uri.parse("${currentIP}/payment/trip/history/${nic}"));
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      details.add(jsonResponse["details"]);
      // print(jsonResponse["details"]);
      if (!details.isEmpty) {
        setState(() {
          isLoad = true;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: size.height,
            color: Color(0xFF2A2A2A),
            child: Stack(
              children: [
                Positioned(
                    top: 30,
                    right: 0,
                    left: 0,
                    child: Container(
                        width: 20,
                        height: 40,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            Text(
                              "Hello  ",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            fname!=null?Text("${fname} ${lname}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFFFCB333),
                                    fontWeight: FontWeight.bold)):
                            Text("",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFFFCB333),
                                    fontWeight: FontWeight.bold))
                          ],
                        ))),
                Positioned(
                    top: 90,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BusRoute()));
                            },
                            child: Container(
                              width: 150.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 90,
                                    child: Image.asset('images/127.jpg'),
                                  ),
                                  Text("Ride",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xFFEC9700),
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRScreen()));
                            },
                            child: Container(
                              width: 150.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      width: 40,
                                      child: Icon(
                                        Icons.qr_code,
                                        color: Color(0xFFECB500),
                                        size: 40.0,
                                      )),
                                  Text("My QR",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Color(0xFFEC9700),
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    width: size.width,
                    height: size.height / 1.9,
                    child: Text(
                      "Trip History",
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: size.width,
                      height: size.height / 2.1,
                      child: isLoad == true
                          ? ListView.builder(
                              itemCount: details[0].length,
                              itemBuilder: (context, index) {
                                return Trip(
                                    location: details[0][index]["busRoute"],
                                    date: details[0][index]["date"]);
                              })
                          : const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 30.0,
                            ),
                    )
                ),
              ],
            )),
      ),
    );
  }
}

class Trip extends StatefulWidget {
  String? location;
  String? date;

  Trip({Key? key, this.location, this.date}) : super(key: key);

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      width: size.width,
      // height: 60.0,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.black12,
      ),
      margin: EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.directions_bus_filled,
            size: 28.0,
            color: Color(0xFFEC9700),
          ),
          SizedBox(
            width: size.width / 1.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.location}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${widget.date!.split("T")[0]}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
