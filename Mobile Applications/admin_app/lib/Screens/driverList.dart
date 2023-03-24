import 'package:driver_app/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:driver_app/Component/qr_scan.dart';
import 'package:driver_app/Screens/profile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

//data = List<Map<String, dynamic>>.from([jsonData]);
import '../Component/ip.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  _DriverListListState createState() => _DriverListListState();
}

class _DriverListListState extends State<DriverList> {
  List data = [];
  
  bool isLoad = false;

  Future<void> getData() async {
    var response = await http.get(Uri.parse("http://localhost:3000/driver/all"));
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      data.add(jsonResponse["drivers"]);
      print(data[0]);
      if (!data.isEmpty) {
        setState(() {
          isLoad = true;
        });
      }
    }
    //  setState(() {
    //    var jsonData = json.decode(response.body);
    //    data = List.from(jsonData);
    //  });
    // return "Success!";
  }

  

  // List<Widget> _buildList() {
  //   return data.map((route) {
  //     String firstName = route['firstName'] ?? '';
  //     String lastName = route['lastName'] ?? '';
  //     return ListTile(
  //       title: Text(firstName),
  //       subtitle: Text(lastName),
  //     );
  //   }).toList();
  // }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                    },
                    child: Image.asset('images/man.png',
                        height: 38.0, width: 38.0, fit: BoxFit.cover),
                  )
                ],
              ),
              SizedBox(
                height: 35.0,
              ),
              // ListView(
              //   children: _buildList(),
              //   shrinkWrap: true,
              // ),

              Container(
                width: size.width,
                height: size.height/1.4,
                color: Color.fromARGB(255, 231, 231, 231),
                child: isLoad == true
                    ? ListView.builder(
                        itemCount: data[0].length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              
                            },
                            child: Card(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(children: [
                                  Text("${data[0][index]["name"]}"),
                                  Text("${data[0][index]["busNo"]}"),
                                  Text("${data[0][index]["routeNo"]}"),
                                  Text("${data[0][index]["contact"]}"),
                                  Text("${data[0][index]["route"]}"),
                                  Text("${data[0][index]["nic"]}"),
                                  
                                ]),
                              ),
                            ),
                          );
                          //return Text( "data", style: TextStyle(color: Color(0xFFFCB333) ), );
                        })
                    : Text("loading"),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}
