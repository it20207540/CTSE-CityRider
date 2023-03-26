import 'package:driver_app/Screens/home_screen.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Component/ip.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? error;
  bool IsError = false;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();





  Future<void> userLogin() async {
    try {
      if (controller1.text.isEmpty || controller2.text.isEmpty) {
        setState(() {
          error = "Enter your credentials.";
          IsError = true;
        });
      } else {
        var response = await http.get(Uri.parse(
            "${currentIp}/admin/login/${controller1.text.toString()}/${controller2.text.toString()}"));
        if (response.statusCode == 200) {
          var jsonResponse =
              convert.jsonDecode(response.body) as Map<String, dynamic>;
          if (jsonResponse["status"] == true) {
            setState(() {
              IsError = false;
            });

            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('username', jsonResponse["data"]["userName"]);
            await prefs.setString('password', jsonResponse["data"]["password"]);
            

            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } else {
            setState(() {
              error = "Invalid credentials.";
              IsError = true;
            });
          }
        } else {
          setState(() {
            error = "Something went wrong.";
            IsError = true;
          });
        }
      }
    } catch (e) {
      setState(() {
        error = "Something went wrong.";
        IsError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png',
                  height: 120, width: size.width / 2, fit: BoxFit.cover),
              SizedBox(
                height: 12.0,
              ),
              Text(
                " CITY RIDER ADMIN",
                style: GoogleFonts.akayaKanadaka(
                    textStyle: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 45.0,
              ),
              TextField(
                controller: controller1,
                decoration: InputDecoration(
                  hintText: "User Name",
                  hintStyle: TextStyle(fontSize: 18.0),
                  prefixIcon: Icon(Icons.person_sharp,color: Colors.black,),
                  prefixIconColor: Colors.black87,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: controller2,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(fontSize: 18.0),
                  prefixIcon: Icon(Icons.password,color: Colors.black,),
                  prefixIconColor: Colors.black87,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              IsError
                  ? Text(
                      "${error}",
                      style: TextStyle(fontSize: 18.0, color: Colors.redAccent),
                    )
                  : Text(""),
              SizedBox(
                height: 60.0,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    userLogin();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: Colors.black87,
                      fixedSize: Size(size.width / 3, 50)),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
