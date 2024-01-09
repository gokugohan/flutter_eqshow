import 'package:eqshow/model/evento.dart';
import 'package:eqshow/screen/screen_moment_tensor.dart';
import 'package:eqshow/utils/EqUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:pulsator/pulsator.dart';
import 'package:timeago/timeago.dart' as timeago;

class ScreenEventDetailScreen extends StatefulWidget {
  ScreenEventDetailScreen({super.key, required this.model});

  final Datum model;
  final mapController = MapController();

  @override
  State<ScreenEventDetailScreen> createState() => _ScreenEventDetailScreenState();
}

class _ScreenEventDetailScreenState extends State<ScreenEventDetailScreen> {
  /// Global Key for taking screenShot
  final GlobalKey globalKey = GlobalKey();

  Position? _currentPosition;
  String? distanceFromMyLocationToEpicenter = "N/A";

  // String? currentAddress;

  //https://medium.com/@fernnandoptr/how-to-get-users-current-location-address-in-flutter-geolocator-geocoding-be563ad6f66a
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
      setState(() {
        _currentPosition = position;
        if (_currentPosition == null) {
          distanceFromMyLocationToEpicenter = widget.model.distanceToCenterPoint.toString();
        } else {
          distanceFromMyLocationToEpicenter = calculateDistanceBetween2Coordenate(
              _currentPosition?.latitude.toString(), _currentPosition?.longitude.toString(), widget.model.latitude, widget.model.longitude, "K");
        }
        // _getAddressFromLatLng(_currentPosition!);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  //
  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //       _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       currentAddress ='${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  //
  // Future<void> _captureScreenShot() async {
  //
  //   RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //
  //   ui.Image image = (await boundary.toImage(pixelRatio: 2));
  //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
  //   Uint8List pngBytes = byteData.buffer.asUint8List();
  //   await Share.shareXFiles([XFile.fromData(pngBytes, mimeType: 'image/png')]);
  // }

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
    eventDateTime = eventDateTime.add(const Duration(hours: 9));

    var eventDate = DateFormat("d-MMM-yyyy").format(eventDateTime);
    var eventTime = DateFormat("HH:mm").format(eventDateTime);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF674AEF),
        elevation: 0,
        title: Text(widget.model.region),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a Appbar Icon example')));
        //         // _captureScreenShot();
        //       },
        //       icon: const Icon(Icons.share))
        // ],
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: Column(
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
                                  point:
                                      latlng.LatLng(double.parse(widget.model.latitude.toString()), double.parse(widget.model.longitude.toString())),
                                  width: 70,
                                  height: 70,
                                  child: Pulsator(
                                    style: const PulseStyle(color: Colors.red),
                                    count: 3,
                                    duration: const Duration(seconds: 1),
                                    repeat: 0,
                                    startFromScratch: false,
                                    autoStart: true,
                                    fit: PulseFit.contain,
                                    child: Text(
                                      widget.model.magnitude.toString(),
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                  // getMagnitudeIcon(double.parse(widget.model.magnitude.toString())),
                                  ),
                            ],
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10, left: 10),
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
                                    width: 65,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
            Expanded(
              flex: 2,
              child: Container(
                  color: const Color(0xFF674AEF),
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Earthquake Details",
                                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/location.gif",
                                        width: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                "Location",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(widget.model.region.toString(),
                                                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_month, size: 35, color: Colors.white54),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text(
                                                    "Date",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text(eventDate,
                                                      style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.timer, size: 35, color: Colors.white54),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text(
                                                    "Time",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text("$eventTime\n${timeago.format(eventDateTime)}",
                                                      style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(right: 0),
                                          child: Image.asset("assets/images/magnitude.png", width: 35, color: Colors.white54)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                "Magnitude",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text("${widget.model.magnitude.toString()} sr",
                                                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.arrow_downward_sharp, size: 35, color: Colors.white54),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                "Depth",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text("${widget.model.depth.toString()} km",
                                                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.arrow_forward_sharp, size: 35, color: Colors.white54),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text(
                                                    "Distance(km)",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text(widget.model.distanceToCenterPoint.toString(),
                                                      style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.arrow_forward_sharp, size: 35, color: Colors.white54),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text(
                                                    "Coordinate",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text("${widget.model.latitude.toString()}, ${widget.model.latitude.toString()}",
                                                      style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.arrow_forward_sharp, size: 35, color: Colors.white54),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                "Distance to my location (km)",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(distanceFromMyLocationToEpicenter.toString(),
                                                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  // (widget.model.hasMt == "1")
                                  //     ? ElevatedButton(
                                  //         onPressed: () {
                                  //           Navigator.of(context)
                                  //               .push(MaterialPageRoute(builder: (context) => ScreenMomentTensor(model: widget.model)));
                                  //         },
                                  //         child: const Text("Moment tensor"),
                                  //       )
                                  //     : const Text("")
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: renderMT(),
    );
  }

  Widget? renderMT() {
    if (widget.model.hasMt == "1") {
      return FloatingActionButton(
        child: Image.network("http://geohazard.ipg.tl:83/moment_tensor/${widget.model.eventId}/media/mt_solution.png",
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return child;
        }, fit: BoxFit.contain),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenMomentTensor(model: widget.model)));
        },
      );
    }

    return null;
  }
}
