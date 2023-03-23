import 'package:flutter/material.dart';
import 'package:passenger_app/Screens/login_screen.dart';
import 'package:passenger_app/Screens/payment.dart';
import 'package:passenger_app/Screens/qr_code_screen.dart';
import 'package:passenger_app/Screens/trip_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? lastName;
  String? nic;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      lastName = prefs.getString('lastName');
      nic = prefs.getString('nic');
    });
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('lastName');
    await prefs.remove('email');
    await prefs.remove('contact');
    await prefs.remove('nic');

    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Color(0xFF2A2A2A),
            child: Stack(
              children: [
                Positioned(
                    top: 50.0,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          child: Image.asset('images/user.png'),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${name} ${lastName}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFFEC9700),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontSize: 17.0, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                Positioned(
                    top: 190.0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: size.width,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRScreen()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.black26,
                              ),
                              padding: EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                  left: 15.0,
                                  right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.qr_code,
                                    size: 30.0,
                                    color: Color(0xFFFCB333),
                                  ),
                                  SizedBox(
                                      width: 120.0,
                                      child: Text(
                                        "View QR",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Icon(
                                    Icons.navigate_next_outlined,
                                    size: 30.0,
                                    color: Color(0xFFFCB333),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Payment(nic:nic)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.black26,
                              ),
                              padding: EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                  left: 15.0,
                                  right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    size: 30.0,
                                    color: Color(0xFFFCB333),
                                  ),
                                  SizedBox(
                                      width: 120.0,
                                      child: Text(
                                        "Recharge",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Icon(
                                    Icons.navigate_next_outlined,
                                    size: 30.0,
                                    color: Color(0xFFFCB333),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TripHistory()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                  left: 15.0,
                                  right: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.black26,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.mode_of_travel,
                                    size: 30.0,
                                    color: Color(0xFFFCB333),
                                  ),
                                  SizedBox(
                                      width: 120.0,
                                      child: Text(
                                        "Trip History",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Icon(
                                    Icons.navigate_next_outlined,
                                    size: 30.0,
                                    color: Color(0xFFFCB333),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              logOut();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                  left: 15.0,
                                  right: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.black26,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: 30.0,
                                    color: Color(0xFFFCB333),
                                  ),
                                  SizedBox(
                                      width: 120.0,
                                      child: Text(
                                        "Log Out",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(
                                    width: 30.0,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
