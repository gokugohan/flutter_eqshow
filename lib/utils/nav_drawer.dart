
import 'package:eqshow/screen/screen_all_data.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.50,
      child: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Home'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                     return const ScreenAllData();
                    })
                ),
              ),
              ListTile(
                title: const Text('About'),
                textColor: Colors.white,
                trailing: Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                ),
                onTap: (){
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => About()))
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
