import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/screen/eq_event_details_screen.dart';
import 'package:eqshow/service/eq_service.dart';
import 'package:eqshow/utils/EqUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:pulsator/pulsator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:latlong2/latlong.dart' as latlng;

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

    if (earthquakeList == null) {
      earthquakeList ??= await _service.fetchEventListApi(50);
    } else {
      if (earthquakeList!.isEmpty) {
        earthquakeList ??= await _service.fetchEventListApi(50);
      }
    }

    return earthquakeList;
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recent Eartquakes"),
        elevation: 0,
        backgroundColor: const Color(0xFF674AEF),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Color(0xFF674AEF),
        indicatorColor: Colors.white,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.map)),
            label: 'Map',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        renderTabList(context),

        renderTabMap(context)
      ][currentPageIndex],
    );
  }

  @override
  void dispose() {
    // scrollController.dispose();
    super.dispose();
  }

  final mapController = MapController();

  Widget renderTabMap(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          initialCenter: latlng.LatLng(-8.560515, 125.541642), initialZoom: 5, interactionOptions: const InteractionOptions(enableScrollWheel: true)),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.chebre.igtl',
        ),
        // const SimpleAttributionWidget(source: Text("IGTL-IP")),

        Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Image.asset(
                "assets/images/map_legend.png",
                width: 150,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Image.asset(
                "assets/images/logo.png",
                width: 75,
              ),
            )
          ],
        ),
        MarkerLayer(
          markers: getMarkers(),
        ),
      ],
    );
  }

  List<Marker> getMarkers() {
    List<Marker> markers = <Marker>[];
    if (earthquakeList != null && earthquakeList!.isNotEmpty) {
      for (int i = 0; i < earthquakeList!.length; i++) {
        EqEvent item = earthquakeList![i];
        markers.add(Marker(
            point: latlng.LatLng(double.parse(item.latitude.toString()), double.parse(item.longitude.toString())),
            width: 50,
            height: 50,
            child: Pulsator(
              style: PulseStyle(color: getMagnitudeColor(double.parse(item.magnitude.toString()))),
              count: 3,
              duration: Duration(seconds: 10),
              repeat: 0,
              startFromScratch: false,
              autoStart: true,
              fit: PulseFit.contain,
              child: Text(item.magnitude.toString()),
            )
            // getMagnitudeIcon(double.parse(item.magnitude.toString())),
            ));
      }
    }
    return markers;
  }

  Widget renderTabList(BuildContext context) {
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
              DateTime eventDateTime = DateTime.parse(item.eventDatetime.toString()).add(Duration(hours: 9));
              var eventDate = DateFormat("d/MMM/yyyy").format(eventDateTime);
              var eventTime = DateFormat("HH:mm").format(eventDateTime);
              return Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: getMagnitudeColor(double.parse(item.magnitude.toString())),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      boxShadow: null,
                      border: null,
                    ),
                    child: Text(
                      "M\n${item.magnitude.toString()}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                  ),
                  //getMagnitudeIcon(double.parse(item.magnitude.toString())),
                  title: Text(
                    item.region.toString(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: getMagnitudeColor(double.parse(item.magnitude.toString()))),
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
                          "Magnitudes: ${item.magnitude} sr\n"
                          "Depth: ${item.depth} km\n"
                          "Distance from HQ to source: ${item.distanceToCenterPoint} km\n"
                          "Date: $eventDate $eventTime (${timeago.format(eventDateTime)})",
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
