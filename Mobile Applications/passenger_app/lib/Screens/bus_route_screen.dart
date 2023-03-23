import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:passenger_app/Screens/map_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'IP.dart';

class BusRoute extends StatefulWidget {



   BusRoute({Key? key}) : super(key: key);

  @override
  State<BusRoute> createState() => _BusRouteState();
}

class _BusRouteState extends State<BusRoute> {
  List details = [];
  bool isLoad = false;



  Future<void> getData() async {
    var response =
        await http.get(Uri.parse("${currentIP}/route/all"));
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      details.add(jsonResponse["route"]);
      print(details[0]);
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
        appBar: AppBar(
          title: Center(child: Text("Bus Route")),
          backgroundColor: Color(0xFF2A2A2A),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          width: size.width,
          height: size.height,
          color: Color(0xFF2A2A2A),
          child: isLoad == true
              ? ListView.builder(
                  itemCount: details[0].length,
                  itemBuilder: (context, index) {
                    return Route(
                        routeNo: details[0][index]["routeNo"],
                        routeName: details[0][index]["routeName"]);
                  })
              : SpinKitThreeBounce(
                  color: Colors.white,
                  size: 30.0,
                ),
        ),
      ),
    );
  }
}

class Route extends StatelessWidget {
  String? routeNo;
  String? routeName;

  Route({Key? key, this.routeNo, this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MapScrenn(routeNo: routeNo,routeName:routeName)));
      },
      child: Container(
        width: size.width,
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        decoration: BoxDecoration(
            color: Colors.black26, borderRadius: BorderRadius.circular(15.0)),
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.directions_bus_filled_rounded,
              color: Color(0xFFFCB333),
              size: 28.0,
            ),
            Container(
              width: size.width/2,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${routeNo}",
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
                            text: '${routeName}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: Color(0xFFFCB333),
              size: 28.0,
            )
          ],
        ),
      ),
    );
  }
}
