import 'package:eqshow/model/drawer_item.dart';
import 'package:eqshow/screen/fragment_all_data.dart';
import 'package:eqshow/screen/fragment_data_radius.dart';
import 'package:eqshow/screen/fragment_home.dart';
import 'package:eqshow/screen/home_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final drawerItem = [
    DrawerItem("Home", Icons.home),
    DrawerItem("All Data", Icons.data_exploration),
    DrawerItem("Data Within Radius", Icons.data_exploration_sharp),
  ];



  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String appBarTitle = "IGTL-IP";
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        setState(() {
          appBarTitle="IGTL-IP";
        });

        return FragmentHome();
      case 1:
        setState(() {
          appBarTitle="IGTL-IP (All Data)";
        });
        return FragmentAllData();
      case 2:
        setState(() {
          appBarTitle="IGTL-IP (Data Radius)";
        });
        return FragmentDataInRadius();
      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];

    drawerOptions.add(
      UserAccountsDrawerHeader(
        decoration: const BoxDecoration(color: Color(0xFF674AEF)),
        accountName: const Text(
          "Instituto do Petróleo e Geologia - Instituto Público",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        accountEmail: const Text("igtlip@gmail.com",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        currentAccountPicture: Image.asset("assets/images/logo.png"),
      ),

      // DrawerHeader(
      //   child: Text("Drawer Header"),
      //   decoration: BoxDecoration(color: Color(0xFF674AEF)),
      // ),
    );

    for (var i = 0; i < widget.drawerItem.length; i++) {
      var d = widget.drawerItem[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        trailing: const Icon(Icons.arrow_right),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    drawerOptions.add(const AboutListTile(
      icon: Icon(
        Icons.info,
      ),
      applicationIcon: Icon(
        Icons.local_play,
      ),
      applicationName: 'Instituto do Petróleo e Geologia - Instituto Público',
      applicationVersion: '1.0',
      applicationLegalese: '© 2023 IGTL-IP',
      // aboutBoxChildren: [Text("Hello there")],
      child: Text('About app'),
    ));
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.menu),
        // ),
        title: Text(appBarTitle),
        backgroundColor: const Color(0xFF674AEF),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // reset list padding
          children: drawerOptions,
        ),
      ),
      body: 
      _getDrawerItemWidget(_selectedDrawerIndex)
      // SizedBox(
      //   width: MediaQuery.of(context).size.width,
      //   height: MediaQuery.of(context).size.height,
      //   child: Stack(
      //     children: [
      //       Stack(
      //         children: [
      //           Container(
      //             width: MediaQuery.of(context).size.width,
      //             height: MediaQuery.of(context).size.height / 4.34,
      //             decoration: const BoxDecoration(
      //               color: Color(0xFF674AEF),
      //               borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
      //             ),
      //             child: Center(
      //               child: Image.asset(
      //                 "assets/images/logo.png",
      //                 width: 150,
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //       Align(
      //         alignment: Alignment.bottomCenter,
      //         child: Container(
      //           width: MediaQuery.of(context).size.width,
      //           height: MediaQuery.of(context).size.height / 1.5,
      //           decoration: const BoxDecoration(
      //             color: Color(0xFF674AEF),
      //           ),
      //         ),
      //       ),
      //       Align(
      //         alignment: Alignment.bottomCenter,
      //         child: Container(
      //           width: MediaQuery.of(context).size.width,
      //           height: MediaQuery.of(context).size.height / 1.5,
      //           padding: const EdgeInsets.only(top: 40, bottom: 30),
      //           decoration: const BoxDecoration(
      //               color: Colors.white,
      //               border: Border(top: BorderSide.none, right: BorderSide.none),
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(70),
      //                 // topRight: Radius.circular(70)
      //               )),
      //           child: Column(
      //             children: [
      //               const Padding(
      //                 padding: EdgeInsets.all(8.0),
      //                 child: Text(
      //                   "Instituto de Geociências de Timor-Leste",
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 height: 15,
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 40),
      //                 child: Text(
      //                   "Earthquake monitoring data",
      //                   style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6)),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 height: 60,
      //               ),
      //               // const CircularProgressIndicator(),
      //               Material(
      //                 color: const Color(0xFF674AEF),
      //                 borderRadius: BorderRadius.circular(10),
      //                 child: InkWell(
      //                   onTap: () {
      //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
      //                   },
      //                   child: Container(
      //                     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
      //                     child: const Text(
      //                       "View Data",
      //                       style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1),
      //                     ),
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
