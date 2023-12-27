import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/screen/eq_event_details_screen.dart';
import 'package:eqshow/service/eq_service.dart';
import 'package:eqshow/utils/EqUtil.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ScreenEqData extends StatefulWidget {
  const ScreenEqData({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ScreenEqData> {
  final EqService _service = EqService();
  List<EqEvent>? earthquakeList;
  bool isLoading = false;

  // final double _value = 10;
  // final String _radius = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scrollController.addListener(loadMore);
    // loadEarthquakeList();
  }

  Future<List<EqEvent>?> fetchAllData() async {
    earthquakeList ??= await _service.fetchEventListApi(50);
    return earthquakeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recent Eartquakes"),
        elevation: 0,
        backgroundColor: const Color(0xFF674AEF),
      ),
      body: renderBody(context),
    );
  }

  @override
  void dispose() {
    // scrollController.dispose();
    super.dispose();
  }

  Widget renderBody(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var topHeaderSize = screenSize.height - (screenSize.height * .80);
    var bodySize = screenSize.height - (screenSize.height * .20);
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: topHeaderSize,
              decoration: const BoxDecoration(
                color: Color(0xFF674AEF),
                // borderRadius: BorderRadius.only(bottomRight: Radius.circular(45),bottomLeft: Radius.circular(45)),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Instituto de Geociências de Timor-Leste - Instituto Público",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Recent Eartquakes",
                      style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: topHeaderSize),
          child: Stack(
            children: [
              // Container(
              //     width: screenSize.width,
              //     height: topHeaderSize,
              //     decoration: const BoxDecoration(color: Color(0xFF674AEF), borderRadius: BorderRadius.only(bottomRight: Radius.circular(45)))
              // ),
              SizedBox(
                width: screenSize.width,
                height: bodySize,
                // decoration: const BoxDecoration(
                //   color: Colors.green,
                //   borderRadius: BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
                // ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: renderList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget renderList() {
    return Scrollbar(
        child: FutureBuilder<List<EqEvent>?>(
      future: fetchAllData(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text("Getting data from IGTL")
              ],
            ),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No Data is retrieved! Service unavailable.",
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
                  leading: getMagnitudeIcon(double.parse(item.magnitude.toString())),
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
                        // Text(
                        //     "Magnitude: ${item.magnitude}\nDepth : ${item.depth} km\nDistance from IGTL Hq: ${item.distanceToCenterPoint} km\nDate(UTC): ${item.eventDatetime}"),
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
