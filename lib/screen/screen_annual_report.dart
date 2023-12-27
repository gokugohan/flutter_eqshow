import 'package:eqshow/model/wp_post.dart';
import 'package:eqshow/service/wp_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenAnnualReport extends StatefulWidget {
  const ScreenAnnualReport({super.key});

  @override
  State<ScreenAnnualReport> createState() => _ScreenAnnualReportState();
}

class _ScreenAnnualReportState extends State<ScreenAnnualReport> {

  final WPService _service = WPService();
  List<WpPost>? newsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scrollController.addListener(loadMore);
    // loadEarthquakeList();
  }

  Future<List<WpPost>?> fetchAllData() async {
    newsList ??= (await _service.fetchPostByCategories(29)).cast<WpPost>();
    return newsList;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var topHeaderSize = screenSize.height - (screenSize.height * .80);
    var bodySize = screenSize.height - (screenSize.height * .20);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Annual Reports"),
          elevation: 0,
          backgroundColor: const Color(0xFF674AEF),
        ),
        body: Stack(
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
                      "Annual Reports",
                      style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: topHeaderSize),
              child: Stack(
                children: [

                  Container(
                    width: screenSize.width,
                    height: bodySize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(90)),
                    ),
                    child: Scrollbar(
                        child: FutureBuilder<List<WpPost>?>(
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
                                  WpPost item = snapshot.data![index];
                                  // DateTime? datetime = item.date;
                                  return Card(
                                    child: ListTile(
                                      leading: Image.asset("assets/images/logo.png"),
                                      title: Html(
                                          data:item.title.toString()
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
                                            Html(data:item.date.toString()),

                                          ],
                                        ),
                                      ),
                                      onTap: () async{
                                        // Uri url = Uri.parse(item.link.toString());
                                        launchURL(item.link.toString());
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenNewsDetails(model: item)));
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
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
