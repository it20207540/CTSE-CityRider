import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:passenger_app/Screens/login_screen.dart';
import 'package:passenger_app/Screens/verification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool IsError = false;
  String? error;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();

  Future<void> userRegister() async {
    try {
      if (controller1.text.isEmpty ||
          controller2.text.isEmpty ||
          controller3.text.isEmpty ||
          controller4.text.isEmpty ||
          controller5.text.isEmpty ||
          controller6.text.isEmpty) {
        setState(() {
          error = "All the fields required!";
          IsError = true;
        });
      } else {
        // var response = await http.post(
        //     Uri.parse("http://192.168.1.3:3000/passenger/register"),
        //     body: {
        //       "firstName": controller1.text.toString(),
        //       "lastName": controller2.text.toString(),
        //       "email": controller3.text.toString(),
        //       "nic": controller4.text.toString(),
        //       "contact": controller5.text.toString(),
        //       "password": controller6.text.toString(),
        //     });
        //
        // if (response.statusCode == 200) {
        //   var jsonResponse =
        //       convert.jsonDecode(response.body) as Map<String, dynamic>;
        //   if (jsonResponse["status"] == true) {
        //     setState(() {
        //       IsError = false;
        //     });
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Verification(
                  fname: controller1.text.toString(),
                  lname: controller2.text.toString(),
                  email: controller3.text.toString(),
                  nic: controller4.text.toString(),
                  password: controller6.text.toString(),
                  contact: controller5.text.toString())),
        );
        //   } else {
        //     setState(() {
        //       error = "Something went wrong.";
        //       IsError = true;
        //     });
        //   }
        // } else {
        //   setState(() {
        //     error = "Something went wrong.";
        //     IsError = true;
        //   });
        // }
      }
    } catch (e) {
      setState(() {
        error = "Something went wrong.";
        IsError = true;
      });
    }
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create Account",
                style: TextStyle(
                    fontSize: 28.0,
                    color: Color(0xFFFCB333),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40.0,
              ),
              TextField(
                controller: controller1,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "First Name",
                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  prefixIcon: Icon(Icons.person_sharp, color: Colors.white),
                  prefixIconColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: controller2,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Last Name",
                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  prefixIcon: Icon(Icons.person_sharp, color: Colors.white),
                  prefixIconColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: controller3,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Email Address",
                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                  prefixIconColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: controller4,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "NIC",
                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  prefixIcon:
                      Icon(Icons.perm_contact_cal_sharp, color: Colors.white),
                  prefixIconColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: controller5,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Contact",
                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  prefixIcon: Icon(Icons.phone_rounded, color: Colors.white),
                  prefixIconColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: controller6,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.white,
                  ),
                  prefixIconColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              IsError == true
                  ? Text(
                      "${error}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.redAccent,
                          fontSize: 17.0),
                    )
                  : Text(""),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    userRegister();
                  },
                  child: Text(
                    "Continue",
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
              SizedBox(
                height: 10.0,
              ),
              TextButton.icon(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
