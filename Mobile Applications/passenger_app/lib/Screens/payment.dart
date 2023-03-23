import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:passenger_app/Screens/profile_screen.dart';

import 'IP.dart';

class Payment extends StatefulWidget {
  String? nic;

  Payment({Key? key,this.nic}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool IsError = false;
  String? error;

  TextEditingController controller1 = TextEditingController();

  Future<void> savePayment() async {
    var response = await http
        .post(Uri.parse("${currentIP}/qr-code/save"), body: {
      "nic": widget.nic,
      "balance":controller1.text.toString(),
    });

    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["status"] == true) {

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      } else {
        setState(() {
          error = "Something went wrong.";
          IsError = true;
          Future.delayed(const Duration(seconds: 2), () {
            IsError = false; // Prints after 1 second.
          });
        });
      }
    } else {
      setState(() {
        error = "Something went wrong.";
        IsError = true;
        Future.delayed(const Duration(seconds: 2), () {
          IsError = false; // Prints after 1 second.
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Recharge")),
        backgroundColor: Color(0xFF2A2A2A),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: Color(0xFF2A2A2A),
          padding: EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Paying Amount",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 17.0),),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 55.0,
                    child: TextField(
                      controller:controller1 ,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                          BorderSide(width: 1, color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                          BorderSide(width: 1, color: Color(0xFFFCB333)),
                        ),
                        hintText: "Paying Amount",
                        hintStyle:
                        TextStyle(fontSize: 17.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Card Number",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 17.0),),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: size.width,
                        height: 55.0,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                              BorderSide(width: 1, color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                              BorderSide(width: 1, color: Color(0xFFFCB333)),
                            ),
                            hintText: "Card Number",
                            hintStyle:
                            TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Expiry Date",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 17.0),),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(

                        width: size.width/2.2,
                        height: 55.0,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                              BorderSide(width: 1, color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                              BorderSide(width: 1, color: Color(0xFFFCB333)),
                            ),
                            hintText: "Date",
                            hintStyle:
                            TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CVV",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 17.0),),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: size.width/2.6,
                        height: 55.0,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                              BorderSide(width: 1, color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                              BorderSide(width: 1, color: Color(0xFFFCB333)),
                            ),
                            hintText: "CVV",
                            hintStyle:
                            TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 17.0),),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 55.0,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                          BorderSide(width: 1, color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                          BorderSide(width: 1, color: Color(0xFFFCB333)),
                        ),
                        hintText: "Name",
                        hintStyle:
                        TextStyle(fontSize: 17.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 28.0,
              ),
              Row(
                children: [
                  Icon(Icons.check_circle,color:Color(0xFFFCB333) ,),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("Save card details.",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 17.0))
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              SizedBox(
                width: size.width / 1.8,
                child:IsError == true
                    ? Text(
                  "${error}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ) : Text(""),),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    savePayment();
                  },
                  child: Text(
                    "Pay",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: Colors.white,
                      fixedSize: Size(size.width / 3, 50)),
                ),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}
