import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

import 'IP.dart';


class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {

  List details = [];
  bool isLoad = false;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nic = prefs.getString('nic');

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF2A2A2A),
        title: Center(
          child: Text("Trip History"),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(20.0),
        color: Color(0xFF2A2A2A),
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
