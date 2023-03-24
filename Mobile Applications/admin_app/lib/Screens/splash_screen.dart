import 'package:driver_app/Screens/home_screen.dart';
import 'package:driver_app/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({Key? key}) : super(key: key);
  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nic = prefs.getString('username');
    if (nic == null) {
      Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              ));
    } else {
      print(nic);
      Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              ));
    }
  }

  // Future<void> waitTask() async {
  //   return await Future.delayed(
  //       const Duration(seconds: 2),
  //       () => Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => const Login()),
  //           ));
  // }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Color(0xffffffff),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Image.asset('images/logo.png',
                height: 120, width: size.width / 2, fit: BoxFit.cover),
            SizedBox(
              height: 12.0,
            ),
            Text(
              " CITY RIDER",
              style: GoogleFonts.akayaKanadaka(
                  textStyle: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 15.0,
            ),
            SpinKitThreeBounce(
              color: Colors.black,
              size: 30.0,
            )
          ],
        )),
      ),
    );
  }
}
