import 'package:eqshow/model/drawer_item.dart';
import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/screen/eq_event_details_screen.dart';
import 'package:eqshow/service/eq_service.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class FragmentAllData extends StatefulWidget {
  FragmentAllData({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FragmentAllData> {
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
    earthquakeList ??= await _service.fetchAllEventListApi();
    return earthquakeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: renderBody(context),
    );
  }

  @override
  void dispose() {
    // scrollController.dispose();
    super.dispose();
  }

  Widget renderBody(BuildContext context) {
    return Scaffold(
      body: SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, child: renderList()),
    );
  }

  Widget renderList() {
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
              DateTime eventDateTime = DateTime.parse(item.eventDatetime.toString());
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
                          "Magnitudes: ${item.magnitude}\n"
                          "Depth: ${item.depth} km\n"
                          "Distance from HQ to source: ${item.distanceToCenterPoint} km\n"
                          "Date(UTC): ${eventDateTime.day}-${eventDateTime.month}-${eventDateTime.year} ${eventDateTime.hour}:${eventDateTime.minute}:${eventDateTime.second} (${timeago.format(eventDateTime)})",
                        ),
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
}
