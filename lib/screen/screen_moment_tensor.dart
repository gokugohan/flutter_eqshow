import 'package:eqshow/model/evento.dart';
import 'package:eqshow/model/moment_tensor.dart';
import 'package:eqshow/repository/eq_repository.dart';
import 'package:eqshow/service/eq_service.dart';
import 'package:eqshow/utils/EqUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScreenMomentTensor extends StatefulWidget {
  const ScreenMomentTensor({super.key, required this.model});

  final Datum model;

  @override
  State<ScreenMomentTensor> createState() => _ScreenMomentTensorState();
}

class _ScreenMomentTensorState extends State<ScreenMomentTensor> {
  final EqService service = EqService();
  List<MomentoTensor>? momentTensorList;

  Future<List<MomentoTensor>?> fetchAllData() async {
    momentTensorList ??= (await service.fetchMomentTensor(widget.model.eventId));
    return momentTensorList;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var topHeaderSize = screenSize.height - (screenSize.height * .80);
    var bodySize = screenSize.height - (screenSize.height * .20);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moment Tensor"),
        elevation: 0,
        backgroundColor: const Color(0xFF674AEF),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<MomentoTensor>?>(
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
                      Text("Getting moment tensor data from IGTL")
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

                return Container(
                  color: const Color(0xFF674AEF),
                  child: ListView.builder(
                    // controller: scrollController,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      MomentoTensor item = snapshot.data![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 150,
                            // width: 150,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Image.network("http://geohazard.ipg.tl:83/moment_tensor/${item.eventId}/media/mt_solution.png",
                                  loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(child: Column(children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 15,),
                                    Text("Getting image",style:TextStyle(color: Colors.white))
                                  ],));
                                }
                              }, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                return child;
                              }, fit: BoxFit.contain),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Container(
                                  width: screenSize.width,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  color: Colors.white30,
                                  child: const Text(
                                    "Centroid Parameters",
                                    style: TextStyle(fontSize: 22, color: Colors.white70, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Origin time",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${DateFormat("d/MMM/yyyy HH:mm:ss").format(item.cpOriginTime)} UTC",
                                              style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Location",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          // Text("${item.cpLatitude}º N, ${item.cpLongitude}º E",
                                          //     style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Depth",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${item.cpDepth} Km", style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Method",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text(item.cpMethod, style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Earth Model",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text(item.cpEarthModel, style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: screenSize.width,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  color: Colors.white30,
                                  child: const Text(
                                    "Focal Mechanism",
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white70),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Nodal plane 1 (S|D|R)",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${item.fmNp1Strike}|${item.fmNp1Dip}|${item.fmNp1Rupture}",
                                              style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Nodal plane 2 (S|D|R)",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${item.fmNp2Strike}|${item.fmNp2Dip}|${item.fmNp2Rupture}",
                                              style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Azimuthal Gap",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${item.fmAzimuthalGap}", style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Misfit",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${item.fmMisfit}", style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: screenSize.width,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  color: Colors.white30,
                                  child: const Text(
                                    "Moment Tensor",
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white70),
                                  ),
                                ),
                                Container(
                                  width: screenSize.width,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Type",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text(item.mtType, style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Scalar Moment",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${double.parse(item.mtScalar).toStringAsExponential(1)} Nm",
                                              style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Tensor elements:\nMrr\nMtt\nMpp\nMrt\nMrp\nMtp",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text(
                                              "${double.parse(item.mtTensorelementsMrr).toStringAsExponential(1)} Nm"
                                              "\n${double.parse(item.mtTensorelementsMtt).toStringAsExponential(1)} Nm"
                                              "\n${double.parse(item.mtTensorelementsMpp).toStringAsExponential(1)} Nm"
                                              "\n${double.parse(item.mtTensorelementsMrt).toStringAsExponential(1)} Nm"
                                              "\n${double.parse(item.mtTensorelementsMrp).toStringAsExponential(1)} Nm"
                                              "\n${double.parse(item.mtTensorelementsMtp).toStringAsExponential(1)} Nm",
                                              style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Deviatoric \nDC\nCLVD",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${item.mtDeviatoric}%\n${item.mtDc}%\n${item.mtClvd}%",
                                              style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "ISO",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Considered stations / phases",
                                            style: TextStyle(fontSize: 20, color: Colors.white70),
                                          ),
                                          Text("${item.mtStations}/${item.mtPhases}", style: const TextStyle(fontSize: 20, color: Colors.white70)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
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
          )
        ],
      ),
    );
  }
}
