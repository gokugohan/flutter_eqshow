import 'package:dotted_border/dotted_border.dart';
import 'package:eqshow/model/eq_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:timeago/timeago.dart' as timeago;

class EqEventDetailScreen extends StatelessWidget {
  EqEventDetailScreen({Key? key, required this.model}) : super(key: key);

  final EqEvent model;
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    DateTime eventDateTime = DateTime.parse(model.eventDatetime.toString()); // time in UTC

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF674AEF),
        elevation: 0,
        title: Text("Region ${model.region}"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFF674AEF),
                child: OrientationBuilder(
                  builder: (context, orientation) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Region ${model.region}",
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Distance from HQ to source: ${model.distanceToCenterPoint} km\n",
                              style: const TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: OrientationBuilder(
                  builder: (context, orientation) => Center(
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                          initialCenter: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
                          initialZoom: 5,
                          interactionOptions: const InteractionOptions(enableScrollWheel: true)),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.chebre.igtl',
                        ),
                        // const SimpleAttributionWidget(source: Text("IGTL-IP")),

                        MarkerLayer(
                          markers: [
                            Marker(
                              point: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
                              width: 50,
                              height: 50,
                              child: Image.asset("assets/images/location.gif"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: OrientationBuilder(
              builder: (context, orientation) => Container(
                color: const Color(0xFF674AEF),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        DottedBorder(
                          color: Colors.white,
                          strokeWidth: 1,
                          dashPattern: const [1,5,],
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Align(
                                //   alignment: Alignment.bottomLeft,
                                //   child: Text(
                                //     "Region ${model.region}",
                                //     style: const TextStyle(
                                //       color: Colors.white,
                                //         fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                                //   ),
                                // ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/images/logo.png",
                                        width: 50,
                                      ),
                                      Text(
                                        "Magnitude ${model.magnitude}",
                                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      Image.asset(
                                        "assets/images/epicenter.png",
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: Text(
                                      "Depth: ${model.depth} km\n"
                                          "Distance from HQ to source: ${model.distanceToCenterPoint} km\n"
                                          "Date(UTC): ${eventDateTime.day}-${eventDateTime.month}-${eventDateTime.year} ${eventDateTime.hour}:${eventDateTime.minute}:${eventDateTime.second}   (${timeago.format(eventDateTime)})",
                                      style: const TextStyle(color: Colors.white, fontSize: 20.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderBody(BuildContext context) {
    DateTime eventDateTime = DateTime.parse(model.eventDatetime.toString()); // time in UTC

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //header container
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            alignment: Alignment.bottomLeft,
            color: Colors.blue,
            child: Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Region ${model.region}",
                        style: const TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Magnitudes: ${model.magnitude}\n"
                        "Depth: ${model.depth} km\n"
                        "Distance from HQ to source: ${model.distanceToCenterPoint} km\n"
                        "Date(UTC): ${eventDateTime.day}-${eventDateTime.month}-${eventDateTime.year} ${eventDateTime.hour}:${eventDateTime.minute}:${eventDateTime.second}   (${timeago.format(eventDateTime)})",
                        style: const TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Body container
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(70))),
            child: Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        initialCenter: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
                        initialZoom: 5,
                        interactionOptions: const InteractionOptions(enableScrollWheel: true)),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.chebre.igtl',
                      ),
                      // const SimpleAttributionWidget(source: Text("IGTL-IP")),

                      MarkerLayer(
                        markers: [
                          Marker(
                            point: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/location.gif"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Footer container
          Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text("Footer"),
          )
        ],
      ),
    );

    //   SizedBox(
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    //   child: Stack(
    //     children: [
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: MediaQuery.of(context).size.height / 3,
    //         decoration: const BoxDecoration(
    //           color: Color(0xFF674AEF),
    //           // color: Colors.green,
    //         ),
    //         child: Column(
    //           children: [
    //             // Image.asset(
    //             //   "assets/images/logo.png",
    //             //   height: 50,
    //             // ),
    //             Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: MediaQuery.of(context).size.height / 10,
    //               color: Colors.red,
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     "Region ${model.region}",
    //                     style: const TextStyle(color: Colors.white, fontSize: 100.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
    //                   ),
    //                   Text(
    //                     "Magnitudes: ${model.magnitude}\n"
    //                     "Depth: ${model.depth} km\n"
    //                     "Distance from HQ to source: ${model.distanceToCenterPoint} km\n"
    //                     "Date(UTC): ${eventDateTime.day}-${eventDateTime.month}-${eventDateTime.year} ${eventDateTime.hour}:${eventDateTime.minute}:${eventDateTime.second}   (${timeago.format(eventDateTime)})",
    //                     style: const TextStyle(fontSize: 15.0, color: Colors.white),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: MediaQuery.of(context).size.height / 3,
    //               padding: const EdgeInsets.only(top: 0, bottom: 0),
    //               decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(70))),
    //               child: Column(
    //                 children: [
    //                   Expanded(
    //                     child: FlutterMap(
    //                       mapController: mapController,
    //                       options: MapOptions(
    //                           initialCenter: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
    //                           initialZoom: 5,
    //                           interactionOptions: const InteractionOptions(enableScrollWheel: true)),
    //                       children: [
    //                         TileLayer(
    //                           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //                           userAgentPackageName: 'com.chebre.igtl',
    //                         ),
    //                         // const SimpleAttributionWidget(source: Text("IGTL-IP")),
    //
    //                         MarkerLayer(
    //                           markers: [
    //                             Marker(
    //                               point: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
    //                               width: 50,
    //                               height: 50,
    //                               child: Image.asset("assets/images/location.gif"),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: MediaQuery.of(context).size.height / 3,
    //               color: Colors.blue,
    //               child: const Text("Hello world"),
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
