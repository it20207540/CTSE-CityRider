import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'IP.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String? nic;
  String? code;
  String? bal;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nic = prefs.getString('nic');
    
    var response = await http.get(Uri.parse(
        "${currentIP}/qr-code/details/${nic}"));
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["status"] == true) {
        setState(() {
          code=jsonResponse["details"]["nic"].toString()+"/"+jsonResponse["details"]["balance"].toString();
          bal=jsonResponse["details"]["balance"].toString();
        });
      }
    }
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("QR Code")),
        backgroundColor: Color(0xFF2A2A2A),
      ),
      body: Container(
          width: size.width,
          height: size.height,
          color: Color(0xFF2A2A2A),
          child:code!=null ? Stack(
            children: [
              Positioned(

                top: 90.0,
                left: 90,

                child: QrImage(
                    data: "${code}",
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                    embeddedImageEmitsError: true),
              ),
              Positioned(
                  top: 330.0,
                  right: 0,
                  left: 0,
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    width: size.width,
                    height: 100.0,
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Credit Balance",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xFFEC9700),
                          ),
                        ),
                        Text(
                          "${bal}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 35.0),
                        )
                      ],
                    ),
                  ))
            ],
          ):SpinKitThreeBounce(
            color: Colors.white,
            size: 30.0,
          ),
      ),
    );
  }
}
