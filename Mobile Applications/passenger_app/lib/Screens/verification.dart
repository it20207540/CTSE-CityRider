import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'IP.dart';
import 'login_screen.dart';

class Verification extends StatefulWidget {
  String? fname;
  String? lname;
  String? email;
  String? nic;
  String? contact;
  String? password;

  Verification(
      {Key? key,
      this.fname,
      this.lname,
      this.email,
      this.nic,
      this.password,
      this.contact})
      : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool IsError = false;
  String? error;
  TextEditingController controller1 = TextEditingController();
  bool IsCorrect = false;
  bool IsSend = false;
  String? message;
  String? code;

  checkCode(e) {
     if(code==e){
       setState(() {
         IsCorrect=true;
       });
     }
  }

  Future<void> sendCode() async {
    var response = await http.get(Uri.parse(
        "${currentIP}/passenger/verification/code/${widget.email}"));

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["status"] == true) {
        print(jsonResponse["message"]);
        print(jsonResponse["code"].toString());
        setState(() {
          message = jsonResponse["message"];
          code = jsonResponse["code"].toString();
          IsSend = true;
        });
        Future.delayed(const Duration(seconds: 3), () {
          IsSend = false;
          setState(() {});
        });
      } else {
        setState(() {
          error = "Something went wrong.";
          IsError = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          IsError = false;
          setState(() {});
        });
      }
    } else {
      setState(() {
        error = "Something went wrong.";
        IsError = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        IsError = false;
        setState(() {});
      });
    }
  }

  Future<void> userRegister() async {
    var response = await http
        .post(Uri.parse("${currentIP}/passenger/register"), body: {
      "firstName": widget.fname,
      "lastName": widget.lname,
      "email": widget.email,
      "nic": widget.nic,
      "contact": widget.contact,
      "password": widget.password,
    });

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["status"] == true) {
        setState(() {
          IsError = false;
        });
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
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
  void initState() {
    sendCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 35.0),
          width: size.width,
          height: size.height,
          color: Color(0xFF2A2A2A),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  top: 55,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Verification",
                      style: TextStyle(
                          fontSize: 28.0,
                          color: Color(0xFFFCB333),
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              Positioned(
                  top: 155,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: size.width / 1.4,
                      child: Text(
                        "We sent you a code to verify your email.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: 235,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      child: Text(
                        "Code is sent to ${widget.email}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xB2FFFFFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: 325,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 220.0,
                      child: TextField(
                        onChanged: (e){
                          checkCode(e);
                        },
                        // controller: controller1,
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
                          hintText: "Code",
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white),
                          suffixIcon: IsCorrect==true
                              ? Icon(Icons.done, color: Color(0xFF00A844))
                              : Icon(Icons.question_mark,
                                  color: Color(0xFF00A844)),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: 410,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't recieve code? ",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xB2FFFFFF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            sendCode();
                          },
                          child: Text(
                            " Request again",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFFFCB333),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )),
                  )),
               Positioned(
                      top: 450,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                          width: size.width / 1.8,
                          child: IsSend == true
                              ? Text(
                            "${message}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF00A844),
                              fontWeight: FontWeight.w500,
                            ),
                          ): Text(""),),
                    ),

                Positioned(
                      top: 450,
                      left: 0,
                      right: 0,
                      child: SizedBox(
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
                    ),

              Positioned(
                  bottom: 110,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: IsCorrect==true?SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          userRegister();
                          // print("hi");
                        },
                        child: Text(
                          "Register",
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
                    ):null,
                  )),
              Positioned(
                  bottom: 52,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                        width: 220.0,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.keyboard_backspace_sharp,
                            color: Color(0xFFFCB333),
                          ),
                          label: Text(
                            "Back",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFFCB333),
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
