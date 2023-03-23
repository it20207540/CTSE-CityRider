import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passenger_app/Screens/login_screen.dart';
import 'package:passenger_app/Screens/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<void> waitTask() async {
  //   return await Future.delayed(
  //       const Duration(seconds: 2),
  //           () => Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const LoginScreen()),
  //       ));
  // }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nic = prefs.getString('nic');
    print(nic);
    if (nic == null) {
      Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ));
    } else {
      Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavBar()),
              ));
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
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
              height: 15.0,
            ),
            SpinKitThreeBounce(
              color: Colors.white,
              size: 30.0,
            )
          ],
        ),
      ),
    ));
  }
}
