import 'package:driver_app/Component/ip.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController controller1 = TextEditingController();

  Barcode? result;
  String? nic;
  String? bal;
  bool isMessage = false;
  String? message;

  QRViewController? controller;

  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        var code = result!.code;
        if (code != null) {
          final splitted = code.split('/');
          print(splitted);
          nic = splitted[0];
          bal = splitted[1];
        }
      });
    });
  }

  savePayment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? dnic = prefs.getString('nic');
    final String? routeNo = prefs.getString('routeNo');
    final String? route = prefs.getString('route');

    if (controller1.text.isEmpty) {
      print("Enter Amount");
    } else {
      var response = await http.post(
          Uri.parse("${currentIp}/payment/detail/save"),
          body: {
            'passengerNIC': nic,
            'driverNIC': dnic,
            'busRouteNo': routeNo,
            'busRoute': route,
            'amount': controller1.text.toString()
          });
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse["status"] == true) {
          print(jsonResponse["message"]);
          setState(() {
            result = null;
            isMessage = true;
            message = jsonResponse["message"];
          });
          Future.delayed(
              const Duration(seconds: 2),
              () => {
                    setState(() {
                      result = null;
                      isMessage = false;
                      message = jsonResponse["message"];
                      controller1.clear();
                    })
                  });
        } else {
          print(jsonResponse["message"]);
          setState(() {
            result = null;
            isMessage = true;
            message = jsonResponse["message"];

          });
          Future.delayed(
              const Duration(seconds: 2),
              () => {
                    setState(() {
                      result = null;
                      isMessage = false;
                      message = jsonResponse["message"];
                      controller1.clear();
                    })
                  });
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30.0),
          width: 250.0,
          height: 250.0,
          child: QRView(
            key: qrKey,
            onQRViewCreated: qr,
          ),
        ),
        result == null
            ? Text(
                "Scan a Code",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              )
            : Column(
                children: [
                  RichText(
                      text: TextSpan(
                          text: "NIC: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text: " ${nic}",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ])),
                  const SizedBox(
                    height: 5.0,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Balance: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text: "Rs ${bal}",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ])),
                ],
              ),
        if (result != null)
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width / 3,
                  child: TextField(
                    controller: controller1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Amount",
                      hintStyle: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    savePayment();
                  },
                  label: Text("Pay"),
                  icon: Icon(Icons.payment),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      fixedSize: Size(size.width / 3, 50)),
                )
              ],
            ),
          ),
        if (isMessage == true)
          Text(
            "${message}",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
      ],
    );
  }
}
