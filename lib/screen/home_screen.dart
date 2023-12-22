import 'package:eqshow/model/drawer_item.dart';
import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/screen/eq_event_details_screen.dart';
import 'package:eqshow/service/eq_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
    HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final EqService _service = EqService();
  List<EqEvent>? earthquakeList;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scrollController.addListener(loadMore);
    // loadEarthquakeList();
  }

  Future<List<EqEvent>?> fetchAllData() async {
    if (earthquakeList == null) {
      print("List is empty");
      earthquakeList = await _service.fetchAllEventListApi();
    }

    return earthquakeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.menu),
        // ),
        title: const Text("Earthquake List"),
        backgroundColor: const Color(0xFF674AEF),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // reset list padding
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF674AEF)),
                accountName: const Text(
                  "Instituto do Petróleo e Geologia - Instituto Público",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: const Text("hchebre@gmail.com",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              currentAccountPicture: Image.asset("assets/images/logo.png"),

            ),
            // DrawerHeader(
            //   child: Text("Drawer Header"),
            //   decoration: BoxDecoration(color: Color(0xFF674AEF)),
            // ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);

              },
            ),


            const AboutListTile(
              icon: Icon(
                Icons.info,
              ),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'Instituto do Petróleo e Geologia - Instituto Público',
              applicationVersion: '1.0',
              applicationLegalese: '© 2023 IGTL-IP',
              aboutBoxChildren: [
                Text("Hello there")
              ],
              child: Text('About app'),
            )
          ],
        ),
      ),
      body: renderBody(),
    );
  }

  @override
  void dispose() {
    // scrollController.dispose();
    super.dispose();
  }

  Widget renderBody() {
    return Scrollbar(
        child: FutureBuilder<List<EqEvent>?>(
      future: fetchAllData(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No Data is retried!",
              ),
            );
          }
          return ListView.builder(
            // controller: scrollController,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              EqEvent item = snapshot.data![index];
              return Card(
                child: ListTile(
                  leading: Image.asset("assets/images/logo.png"),
                  title: Text(
                    item.region.toString(),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF7159E3),
                  ),
                  contentPadding: const EdgeInsets.all(1),
                  subtitle: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      children: [
                        Text(
                            "Magnitude: ${item.magnitude}\nDepth : ${item.depth}\nDistance from IGTL Hq: ${item.magnitude}\nDate(UTC): ${item.eventDatetime}"),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EqEventDetailScreen(model: item)));
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
    // }
  }

// void loadMore() {
//   if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//     setState(() {
//       currentPage++;
//       list.addAll(List.generate(20, (index) => "Item ${index + 1 + currentPage * 20}"));
//     });
//   }
// }
}
