import 'package:driver_app/Screens/login_screen.dart';
import'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    setState(() {

    });
  }

  logOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('nic');
    await prefs.remove('routeNo');
    await prefs.remove('route');
    await prefs.remove('password');
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()));
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
            color: Colors.white,
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
                              "${name}",
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
                                color: Colors.black,
                              ),
                              label: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontSize: 17.0, color: Colors.black),
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
                                color: Color(0x93e7e7e7),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: 30.0,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                      width: 120.0,
                                      child: Text(
                                        "Log Out",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
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
