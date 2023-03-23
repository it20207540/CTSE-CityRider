import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passenger_app/Screens/navigation_screen.dart';
import 'package:passenger_app/Screens/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'IP.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool IsError = false;

  String? error;
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
            "${currentIP}/passenger/login/${controller1.text.toString()}/${controller2.text.toString()}"));
        if (response.statusCode == 200) {
          var jsonResponse =
              convert.jsonDecode(response.body) as Map<String, dynamic>;
          if (jsonResponse["status"] == true) {
            setState(() {
              IsError = false;
            });

            print(jsonResponse["data"]["firstName"]);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('name',jsonResponse["data"]["firstName"]);
            await prefs.setString('lastName', jsonResponse["data"]["lastName"]);
            await prefs.setString('email', jsonResponse["data"]["email"]);
            await prefs.setString('nic', jsonResponse["data"]["nic"]);
            await prefs.setString('contact', jsonResponse["data"]["contact"]);

            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => NavBar()));
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(18.0),
          color: Color(0xFF2A2A2A),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width / 1.6,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                " CITY RIDER",
                style: GoogleFonts.akayaKanadaka(
                    textStyle: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
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
                controller: controller2,
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
              IsError
                  ? Text(
                "${error}",
                style: TextStyle(fontSize: 18.0, color: Colors.redAccent),
              )
                  : Text(""),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    userLogin();
                  },
                  child: Text(
                    "Sign in",
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
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ",
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(" Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.5,
                              color: Color(0xFFFCB333))))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
