import 'package:eqshow/model/drawer_item.dart';
import 'package:eqshow/screen/screen_about_us.dart';
import 'package:eqshow/screen/screen_all_data.dart';
import 'package:eqshow/screen/screen_events_data.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
   WelcomeScreen({super.key});
  final drawerItems = [
    DrawerItem("Home", Icons.home),
    // DrawerItem("Query Event by Radius", Icons.local_pizza),
    DrawerItem("About Us", Icons.info)
  ];
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
      //   return  const ScreenEventData();
      // case 1:
        return  const ScreenAllData();
      case 1:
        return  const ScreenAboutUs();

      default:
        return  const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.drawerItems[_selectedDrawerIndex].title),
        backgroundColor: const Color(0xFF674AEF),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Instituto de Geociências de Timor-Leste"),
              accountEmail: Text("Instituto Público (IGTL-IP)"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
              decoration: BoxDecoration(
                  color: Color(0xFF674AEF)
              ),
            ),


            Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
