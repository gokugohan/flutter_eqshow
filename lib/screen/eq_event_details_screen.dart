import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/utils/EqUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:timeago/timeago.dart' as timeago;

class EqEventDetailScreen extends StatefulWidget {
  EqEventDetailScreen({super.key, required this.model});

  final EqEvent model;
  final mapController = MapController();

  @override
  State<EqEventDetailScreen> createState() => _EqEventDetailScreenState();
}

class _EqEventDetailScreenState extends State<EqEventDetailScreen> {
  Position? _currentPosition;
  String? distanceFromMyLocationToEpicenter="N/A";

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState((){
        _currentPosition = position;
        if (_currentPosition == null) {
          distanceFromMyLocationToEpicenter= widget.model.distanceToCenterPoint.toString();
        }else{
          distanceFromMyLocationToEpicenter = distancessss(
              _currentPosition?.latitude.toString(), _currentPosition?.longitude.toString(), widget.model.latitude, widget.model.longitude, "K");

          print(distanceFromMyLocationToEpicenter);
        }
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    DateTime eventDateTime = DateTime.parse(widget.model.eventDatetime.toString()); // time in UTC

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF674AEF),
        elevation: 0,
        title: Text("Region ${widget.model.region}"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                child: OrientationBuilder(
                  builder: (context, orientation) => Center(
                    child: FlutterMap(
                      mapController: widget.mapController,
                      options: MapOptions(
                          initialCenter:
                              latlng.LatLng(double.parse(widget.model.latitude.toString()), double.parse(widget.model.longitude.toString())),
                          initialZoom: 9,
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
                              point: latlng.LatLng(double.parse(widget.model.latitude.toString()), double.parse(widget.model.longitude.toString())),
                              width: 50,
                              height: 50,
                              child: getMagnitudeIcon(double.parse(widget.model.magnitude.toString())),
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
            child: Container(
                color: Color(0xFF674AEF),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            // leading: Icon(Icons.car_rental),
                            title: Text(
                              "Eartquake Details",
                              style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                            ),
                            // trailing: Icon(Icons.more_vert),
                          ),
                          ListTile(
                              leading: Image.asset(
                                "assets/images/location.gif",
                                width: 50,
                              ),
                              title: Text(
                                "Location",
                                style: const TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                              ),
                              contentPadding: const EdgeInsets.all(1),
                              subtitle: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(widget.model.region.toString(),
                                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                              )),
                          ListTile(
                              leading: Icon(Icons.lock_clock,size: 50,),
                              title: Text(
                                "Date(UTC)",
                                style: const TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                              ),
                              contentPadding: const EdgeInsets.all(1),
                              subtitle: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text("${eventDateTime.toString()} (${timeago.format(eventDateTime)})",
                                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                  leading: Image.asset(
                                    "assets/images/magnitude.png",
                                    width: 50,
                                  ),
                                  title: Text(
                                    "Magnitude",
                                    style: const TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                  ),
                                  contentPadding: const EdgeInsets.all(1),
                                  subtitle: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(widget.model.magnitude.toString(),
                                        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                                leading: Icon(Icons.arrow_downward_sharp,size: 50,),
                                title: Text(
                                  "Depth",
                                  style: const TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                ),
                                contentPadding: const EdgeInsets.all(1),
                                subtitle: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(widget.model.depth.toString(),
                                      style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                )),
                          ],
                        )),
                      ],
                    ),

                    Expanded(
                        child: ListView(
                      shrinkWrap: true,
                      children: [

                        ListTile(
                            leading: Icon(Icons.arrow_forward_sharp,size: 50,),
                            title: Text(
                              "Distance(km)",
                              style: const TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                            ),
                            contentPadding: const EdgeInsets.all(1),
                            subtitle: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(widget.model.distanceToCenterPoint.toString(),
                                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                            )),
                        ListTile(
                            leading: Icon(Icons.arrow_forward_sharp,size: 50,),
                            title: Text(
                              "Distance from my location (km)",
                              style: const TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                            ),
                            contentPadding: const EdgeInsets.all(1),
                            subtitle: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(distanceFromMyLocationToEpicenter.toString(),
                                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                            )),
                        ListTile(
                            leading: Icon(Icons.share_location,size: 50.0),
                            title: Text(
                              "Coordinate",
                              style: const TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                            ),
                            contentPadding: const EdgeInsets.all(1),
                            subtitle: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("${widget.model.latitude.toString()}, ${widget.model.latitude.toString()}",
                                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                            )),
                      ],
                    ))
                  ],
                )

                // Column(
                //   children: [
                //     const Align(
                //       alignment: Alignment.bottomLeft,
                //       child: Text(
                //         "Eartquake Details",
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                //       ),
                //     ),

                //
                //
                //   ],
                // ),
                ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.my_location),
      //   onPressed: () {
      //     _getCurrentPosition();
      //   },
      // ),
    );
  }

  Widget renderBody(BuildContext context) {
    DateTime eventDateTime = DateTime.parse(widget.model.eventDatetime.toString()); // time in UTC

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
                        "Region ${widget.model.region}",
                        style: const TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Magnitudes: ${widget.model.magnitude}\n"
                        "Depth: ${widget.model.depth} km\n"
                        "Distance from HQ to source: ${widget.model.distanceToCenterPoint} km\n"
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
                    mapController: widget.mapController,
                    options: MapOptions(
                        initialCenter: latlng.LatLng(double.parse(widget.model.latitude.toString()), double.parse(widget.model.longitude.toString())),
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
                            point: latlng.LatLng(double.parse(widget.model.latitude.toString()), double.parse(widget.model.longitude.toString())),
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/marker_icon.png"),
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
            padding: const EdgeInsets.all(8.0),
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text("Footer"),
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

//
// class EqEventDetailScreens extends StatefulWidget {
//   EqEventDetailScreens({Key? key, required this.model}) : super(key: key);
//
//   final EqEvent model;
//   final mapController = MapController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     Orientation orientation = MediaQuery.of(context).orientation;
//     DateTime eventDateTime = DateTime.parse(model.eventDatetime.toString()); // time in UTC
//
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF674AEF),
//         elevation: 0,
//         title: Text("Region ${model.region}"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//               flex: 1,
//               child: Container(
//                 color: const Color(0xFF674AEF),
//                 child: OrientationBuilder(
//                   builder: (context, orientation) => Center(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               "Region ${model.region}",
//                               style:
//                                   const TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               "Distance from HQ to source: ${model.distanceToCenterPoint} km\n",
//                               style: const TextStyle(fontSize: 18.0, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )),
//           Expanded(
//               flex: 3,
//               child: Container(
//                 color: Colors.blue,
//                 child: OrientationBuilder(
//                   builder: (context, orientation) => Center(
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
//                               child: Image.asset("assets/images/magnitude.png"),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//           Expanded(
//             flex: 2,
//             child: OrientationBuilder(
//               builder: (context, orientation) => Container(
//                 color: const Color(0xFF674AEF),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       children: [
//                         DottedBorder(
//                           color: Colors.white,
//                           strokeWidth: 1,
//                           dashPattern: const [1,5,],
//                           child: Container(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 // Align(
//                                 //   alignment: Alignment.bottomLeft,
//                                 //   child: Text(
//                                 //     "Region ${model.region}",
//                                 //     style: const TextStyle(
//                                 //       color: Colors.white,
//                                 //         fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
//                                 //   ),
//                                 // ),
//                                 Align(
//                                   alignment: Alignment.bottomLeft,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Image.asset(
//                                         "assets/images/logo.png",
//                                         width: 50,
//                                       ),
//                                       Text(
//                                         "Magnitude ${model.magnitude}",
//                                         style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//                                       ),
//                                       Image.asset(
//                                         "assets/images/magnitude.png",
//                                         width: 50,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.bottomLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       "Depth: ${model.depth} km\n"
//                                           "Distance from HQ to source: ${model.distanceToCenterPoint} km\n"
//                                           "Date(UTC): ${eventDateTime.day}-${eventDateTime.month}-${eventDateTime.year} ${eventDateTime.hour}:${eventDateTime.minute}:${eventDateTime.second}   (${timeago.format(eventDateTime)})",
//                                       style: const TextStyle(color: Colors.white, fontSize: 18.0),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//
//
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget renderBody(BuildContext context) {
//     DateTime eventDateTime = DateTime.parse(model.eventDatetime.toString()); // time in UTC
//
//     return SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           //header container
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 1.5,
//             padding: const EdgeInsets.only(top: 10, bottom: 15),
//             alignment: Alignment.bottomLeft,
//             color: Colors.blue,
//             child: Align(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Text(
//                         "Region ${model.region}",
//                         style: const TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Text(
//                         "Magnitudes: ${model.magnitude}\n"
//                         "Depth: ${model.depth} km\n"
//                         "Distance from HQ to source: ${model.distanceToCenterPoint} km\n"
//                         "Date(UTC): ${eventDateTime.day}-${eventDateTime.month}-${eventDateTime.year} ${eventDateTime.hour}:${eventDateTime.minute}:${eventDateTime.second}   (${timeago.format(eventDateTime)})",
//                         style: const TextStyle(fontSize: 15.0, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Body container
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 1.5,
//             padding: const EdgeInsets.only(top: 0, bottom: 0),
//             decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(70))),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: FlutterMap(
//                     mapController: mapController,
//                     options: MapOptions(
//                         initialCenter: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
//                         initialZoom: 5,
//                         interactionOptions: const InteractionOptions(enableScrollWheel: true)),
//                     children: [
//                       TileLayer(
//                         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                         userAgentPackageName: 'com.chebre.igtl',
//                       ),
//                       // const SimpleAttributionWidget(source: Text("IGTL-IP")),
//
//                       MarkerLayer(
//                         markers: [
//                           Marker(
//                             point: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
//                             width: 50,
//                             height: 50,
//                             child: Image.asset("assets/images/location.gif"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Footer container
//           Container(
//             padding: EdgeInsets.all(8.0),
//             color: Colors.blue,
//             alignment: Alignment.center,
//             child: Text("Footer"),
//           )
//         ],
//       ),
//     );
//
//     //   SizedBox(
//     //   width: MediaQuery.of(context).size.width,
//     //   height: MediaQuery.of(context).size.height,
//     //   child: Stack(
//     //     children: [
//     //       Container(
//     //         width: MediaQuery.of(context).size.width,
//     //         height: MediaQuery.of(context).size.height / 3,
//     //         decoration: const BoxDecoration(
//     //           color: Color(0xFF674AEF),
//     //           // color: Colors.green,
//     //         ),
//     //         child: Column(
//     //           children: [
//     //             // Image.asset(
//     //             //   "assets/images/logo.png",
//     //             //   height: 50,
//     //             // ),
//     //             Container(
//     //               width: MediaQuery.of(context).size.width,
//     //               height: MediaQuery.of(context).size.height / 10,
//     //               color: Colors.red,
//     //               child: Column(
//     //                 children: [
//     //                   Text(
//     //                     "Region ${model.region}",
//     //                     style: const TextStyle(color: Colors.white, fontSize: 100.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
//     //                   ),
//     //                   Text(
//     //                     "Magnitudes: ${model.magnitude}\n"
//     //                     "Depth: ${model.depth} km\n"
//     //                     "Distance from HQ to source: ${model.distanceToCenterPoint} km\n"
//     //                     "Date(UTC): ${eventDateTime.day}-${eventDateTime.month}-${eventDateTime.year} ${eventDateTime.hour}:${eventDateTime.minute}:${eventDateTime.second}   (${timeago.format(eventDateTime)})",
//     //                     style: const TextStyle(fontSize: 15.0, color: Colors.white),
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //             Container(
//     //               width: MediaQuery.of(context).size.width,
//     //               height: MediaQuery.of(context).size.height / 3,
//     //               padding: const EdgeInsets.only(top: 0, bottom: 0),
//     //               decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(70))),
//     //               child: Column(
//     //                 children: [
//     //                   Expanded(
//     //                     child: FlutterMap(
//     //                       mapController: mapController,
//     //                       options: MapOptions(
//     //                           initialCenter: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
//     //                           initialZoom: 5,
//     //                           interactionOptions: const InteractionOptions(enableScrollWheel: true)),
//     //                       children: [
//     //                         TileLayer(
//     //                           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//     //                           userAgentPackageName: 'com.chebre.igtl',
//     //                         ),
//     //                         // const SimpleAttributionWidget(source: Text("IGTL-IP")),
//     //
//     //                         MarkerLayer(
//     //                           markers: [
//     //                             Marker(
//     //                               point: latlng.LatLng(double.parse(model.latitude.toString()), double.parse(model.longitude.toString())),
//     //                               width: 50,
//     //                               height: 50,
//     //                               child: Image.asset("assets/images/location.gif"),
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //             Container(
//     //               width: MediaQuery.of(context).size.width,
//     //               height: MediaQuery.of(context).size.height / 3,
//     //               color: Colors.blue,
//     //               child: const Text("Hello world"),
//     //             )
//     //           ],
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }
