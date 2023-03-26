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
import 'package:driver_app/Screens/map_screen.dart';

//data = List<Map<String, dynamic>>.from([jsonData]);
import '../Component/ip.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MyListView extends StatefulWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List data = [];
  final TextEditingController routeNoController = TextEditingController();
  final TextEditingController routeNameController = TextEditingController();

  final TextEditingController routeNoController1 = TextEditingController();
  final TextEditingController routeNameController2 = TextEditingController();

  bool isLoad = false;

  Future<void> getData() async {
    var response = await http.get(Uri.parse("http://localhost:3000/route/all"));
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      data.add(jsonResponse["route"]);
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

  Future<void> postData() async {
    var url = Uri.parse("http://localhost:3000/route/register");
    var response = await http.post(url,
        //headers: {
        //    "Content-Type": "application/json"
        // },
        body: {
          "routeNo": routeNoController.text,
          "routeName": routeNameController.text
        });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    getData();

    routeNoController.clear();
    routeNameController.clear();
  }

  Future<void> deleteRoute(String id) async {
    var response = await http
        .delete(Uri.parse("http://localhost:3000/route/details/delete/$id"));
    if (response.statusCode == 200) {
      print("Route deleted successfully");
      // call the getData method to refresh the routes list
      getData();
    } else {
      print("Failed to delete route. Error: ${response.statusCode}");
    }
  }

  Future<void> updateData(String id) async {
    final url = Uri.parse('http://localhost:3000/route/details/update/$id');
    //final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.put(url, body: {
        "routeNo": routeNoController1.text,
        "routeName": routeNameController2.text
      });
      if (response.statusCode == 200) {
        print('Data updated successfully');
      } else {
        print('Failed to update data');
      }
    } catch (error) {
      print('An error occurred while updating data: $error');
    }
    routeNoController1.clear();
    routeNameController2.clear();
  }

  List<Widget> _buildList() {
    return data.map((route) {
      String routeNo = route['routeNo'] ?? '';
      String routeName = route['routeName'] ?? '';
      return ListTile(
        title: Text(routeNo),
        subtitle: Text(routeName),
      );
    }).toList();
  }

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
                height: size.height / 1.4,
                color: Color.fromARGB(255, 231, 231, 231),
                child: isLoad == true
                    ? RefreshIndicator(
                        onRefresh: getData,
                        child: ListView.builder(
                            itemCount: data[0].length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MapScrenn(
                                                  routeNo:
                                                      "${data[0][index]["routeNo"]}",
                                                  routeName:
                                                      "${data[0][index]["routeName"]}")));
                                    },
                                    onLongPress: () {
                                      routeNoController1.text =
                                          "${data[0][index]["routeNo"]}";
                                      routeNameController2.text =
                                          "${data[0][index]["routeName"]}";
                                      //start
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Edit route"),
                                              content: Form(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          routeNoController1,
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "Route Number"),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          routeNameController2,
                                                      decoration:
                                                          InputDecoration(
                                                              labelText:
                                                                  "Route Name"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    updateData(
                                                        "${data[0][index]["_id"]}");
                                                    // Navigator.of(context).pop();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyListView()));
                                                  },
                                                  child: Text("Submit"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                              ],
                                            );
                                          });

                                      //end
                                    },
                                    title: Text("${data[0][index]["routeNo"]}"),
                                    subtitle:
                                        Text("${data[0][index]["routeName"]}"),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          deleteRoute(
                                              "${data[0][index]["_id"]}");
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             MyListView()));
                                        },
                                        child: Icon(Icons.delete)),
                                  ),
                                ),
                              );
                              //return Text( "data", style: TextStyle(color: Color(0xFFFCB333) ), );
                            }),
                      )
                    : Text("loading"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Add new route"),
                  content: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: routeNoController,
                          decoration:
                              InputDecoration(labelText: "Route Number"),
                        ),
                        TextFormField(
                          controller: routeNameController,
                          decoration: InputDecoration(labelText: "Route Name"),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        postData();
                        // Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyListView()));
                      },
                      child: Text("Save"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
