import 'dart:ui';

import 'package:eqshow/model/evento.dart';
import 'package:eqshow/screen/screen_event_details_screen.dart';
import 'package:eqshow/service/eq_service.dart';
import 'package:eqshow/utils/EqUtil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:pulsator/pulsator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:latlong2/latlong.dart' as latlng;

class ScreenEventData extends StatefulWidget {
  const ScreenEventData({Key? key}) : super(key: key);

  @override
  _ScreenEventDataState createState() => _ScreenEventDataState();
}

class _ScreenEventDataState extends State<ScreenEventData> {
  final EqService _service = EqService();
  Evento? evento;
  List<Datum>? datums = List.empty(growable: true);
  bool canLoadMoreData = true;

  int currentTabPageIndex = 0;
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  String api_url = "http://geohazard.igtl.tl:83/api/events/paginate/100/radius?page=1";

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      evento ??= await _service.fetchData(api_url);
      setState(() {
        datums!.addAll(evento!.data);
        // if next page url is null, then assign default api url
        api_url = evento!.nextPageUrl ?? "http://geohazard.igtl.tl:83/api/events/paginate/100/radius?page=1";

        evento = null;
      });
    } catch (err) {
      datums = [];
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (api_url != "" && _isFirstLoadRunning == false && _isLoadMoreRunning == false && scrollController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      try {
        evento ??= await _service.fetchData(api_url);
        if (evento!.data.isNotEmpty) {
          setState(() {
            datums!.addAll(evento!.data);
            api_url = evento!.nextPageUrl ?? "";
            evento = null;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void fetchData() async {
    try {
      print("api_url: $api_url");

      if (api_url != "") {
        evento ??= await _service.fetchData(api_url);
        setState(() {
          datums!.addAll(evento!.data);
          api_url = evento!.nextPageUrl ?? "";
          evento = null;
        });
      }
    } catch (error) {
      print(error);
      print("An error occurred: $error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstLoad();
    scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentTabPageIndex = index;
          });
        },
        backgroundColor: const Color(0xFF674AEF),
        indicatorColor: Colors.white,
        selectedIndex: currentTabPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.map),
            label: '',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _firstLoad(),
        elevation: 0,
        backgroundColor: const Color(0xFF674AEF),
        child: const Icon(Icons.refresh),
      ),
      body: <Widget>[renderTabList(context), renderTabMap(context)][currentTabPageIndex],
    );
  }

  final mapController = MapController();

  Widget renderTabMap(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: const MapOptions(
        initialCenter: latlng.LatLng(-8.560515, 125.541642),
        initialZoom: 5,
        interactionOptions: InteractionOptions(enableScrollWheel: true),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.chebre.igtl',
        ),
        // const SimpleAttributionWidget(source: Text("IGTL-IP")),
        MarkerLayer(
          markers: getMarkers(),
        ),
        Stack(
          children: [
            // Align(
            //     alignment: AlignmentDirectional.topEnd,
            //     child: Column(
            //       children: [
            //         Container(
            //             margin: const EdgeInsets.only(top: 10, right: 10),
            //             padding: const EdgeInsets.all(8.0),
            //             decoration: const BoxDecoration(
            //               color: Color(0xFF674AEF),
            //               borderRadius: BorderRadius.all(Radius.circular(10)),
            //             ),
            //             child: InkWell(
            //               onTap: () {
            //               },
            //               child: Icon(Icons.zoom_in, color: Colors.white),
            //             )),
            //         Container(
            //             margin: const EdgeInsets.only(top: 10, right: 10),
            //             padding: const EdgeInsets.all(8.0),
            //             decoration: const BoxDecoration(
            //               color: Color(0xFF674AEF),
            //               borderRadius: BorderRadius.all(Radius.circular(10)),
            //             ),
            //             child: InkWell(
            //               onTap: () {},
            //               child: Icon(Icons.zoom_out,color: Colors.white),
            //             )),
            //       ],
            //     )),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: Image.asset(
                  "assets/images/map_legend.png",
                  width: 150,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 10),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 75,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> _showMyDialog(Datum item) async {
    DateTime eventDateTime = DateTime.parse(item.eventDatetime.toString()).add(Duration(hours: 9));
    var eventDate = DateFormat("d/MMM/yyyy HH:mm").format(eventDateTime);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF674AEF),
          title: Text(item.region.toString(), style: const TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Magnitude: ${item.magnitude.toString()}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text('Depth: ${item.depth.toString()}', style: const TextStyle(color: Colors.white)),
                Text('Date: ${timeago.format(eventDateTime)}', style: const TextStyle(color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Would you like to view the details of Event?',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenEventDetailScreen(model: item)));
              },
            ),
          ],
        );
      },
    );
  }

  List<Marker> getMarkers() {
    List<Marker> markers = <Marker>[];
    bool isFirstItem = true;
    if (datums != null && datums!.isNotEmpty) {
      for (int i = 0; i < datums!.length; i++) {
        Datum? item = datums![i];

        if (isFirstItem) {
          markers.add(Marker(
              point: latlng.LatLng(double.parse(item.latitude), double.parse(item.longitude)),
              width: 50,
              height: 50,
              child: SizedBox(
                width: 150,
                height: 150,
                child: InkWell(
                  onTap: () {
                    _showMyDialog(item);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenEventDetailScreen(model: item)));
                  },
                  child: createMarkerPulse(item.magnitude, Colors.red, 1, PulseFit.cover),
                ),
              )));
          isFirstItem = false;
        } else {
          markers.add(Marker(
            point: latlng.LatLng(double.parse(item.latitude), double.parse(item.longitude)), width: 50, height: 50,
            child: InkWell(
              onTap: () {
                _showMyDialog(item);
              },
              child: createMarkerPulse(item.magnitude, getMagnitudeColor(double.parse(item.magnitude.toString())), 10, PulseFit.contain),
            ),
            // ,
          ));
        }
      }
    }
    return markers;
  }

  Widget createMarkerPulse(String magnitude, Color color, int seconds, PulseFit pulseFit) {
    return Pulsator(
      style: PulseStyle(color: color),
      count: 3,
      duration: Duration(seconds: seconds),
      repeat: 0,
      startFromScratch: false,
      autoStart: true,
      fit: pulseFit,
      child: Text(
        magnitude,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget renderTabList(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var topHeaderSize = screenSize.height - (screenSize.height * .80);
    var bodySize = screenSize.height - (screenSize.height * 0.2);
    return SafeArea(
        child: Stack(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: topHeaderSize,
              decoration: const BoxDecoration(
                color: Color(0xFF674AEF),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
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
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 40),
                  //   child: Text(
                  //     "Recent Eartquakes",
                  //     style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6)),
                  //   ),
                  // ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: renderList(),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }

  Widget renderList() {
    return _isFirstLoadRunning
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Getting data from IGTL",
                )
              ],
            ),
          )
        : getEventListView();
  }

  Widget getEventListView() {
    if (datums!.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No data is retrieved!\nResource may not available just now! Please try again later.",
                textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic))
          ],
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: datums!.length,
            itemBuilder: (BuildContext context, int index) {
              Datum item = datums![index];
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
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: getMagnitudeColor(double.parse(item.magnitude.toString())),
                  ),
                  contentPadding: const EdgeInsets.all(1),
                  subtitle: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Magnitudes: ${item.magnitude} sr\n"
                          "Depth: ${item.depth} km\n"
                          "Distance from HQ to source: ${item.distanceToCenterPoint} km\n"
                          "Date: $eventDate $eventTime (${timeago.format(eventDateTime)})"
                          "${item.hasMt == 1 ? "\nHas Moment tensor" : ""}",
                        ),
                        item.hasMt == 1
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.network("http://geohazard.ipg.tl:83/moment_tensor/${item.eventId}/media/mt_solution.png",
                                    loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                }, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                  return child;
                                }, fit: BoxFit.contain),
                              )
                            : const SizedBox(
                                height: 0,
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenEventDetailScreen(model: item)));
                  },
                ),
              );
            },
          ),
        ),
        // when the _loadMore function is running
        if (_isLoadMoreRunning == true)
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: Column(
                children: [CircularProgressIndicator(), Text("Load more....")],
              ),
            ),
          ),

        // When nothing else to load
        if (api_url == "")
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration:
                const BoxDecoration(color: Color(0xFF674AEF), borderRadius: BorderRadius.all(Radius.circular(90)), boxShadow: null, border: null),
            child: const Center(
              child: Text(
                'You have fetched all of the content',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
      ],
    );
  }
}
