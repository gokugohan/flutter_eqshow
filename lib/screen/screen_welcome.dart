import 'package:eqshow/model/drawer_item.dart';
import 'package:eqshow/screen/screen_home.dart';
import 'package:flutter/material.dart';

class ScreenWelcome extends StatefulWidget {
  ScreenWelcome({Key? key}) : super(key: key);

  final drawerItem = [
    DrawerItem("Home", Icons.home),
    DrawerItem("All Data", Icons.data_exploration),
    DrawerItem("Data Within Radius", Icons.data_exploration_sharp),
  ];

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<ScreenWelcome> {
  String appBarTitle = "IGTL-IP";

  @override
  void initState() {
    super.initState();
    //
    // InternetConnectionChecker().onStatusChange.listen((status) {
    //   switch (status) {
    //     case InternetConnectionStatus.connected:
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Internet connection restored")));
    //       break;
    //     case InternetConnectionStatus.disconnected:
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are disconnected from internet")));
    //       break;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:ScreenHome()
    );
  }

  Widget renderWelcomeScreen() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4.34,
                decoration: const BoxDecoration(
                  color: Color(0xFF674AEF),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 150,
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: const BoxDecoration(
                color: Color(0xFF674AEF),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide.none, right: BorderSide.none),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    // topRight: Radius.circular(70)
                  )),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Instituto de Geociências de Timor-Leste",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Earthquake monitoring data",
                      style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  // const CircularProgressIndicator(),
                  Material(
                    color: const Color(0xFF674AEF),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        child: const Text(
                          "View Data",
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
