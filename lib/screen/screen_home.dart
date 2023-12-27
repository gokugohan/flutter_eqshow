import 'package:eqshow/model/igtl_grid_item.dart';
import 'package:eqshow/screen/screen_about_us.dart';
import 'package:eqshow/screen/screen_annual_report.dart';
import 'package:eqshow/screen/screen_eq_data.dart';
import 'package:eqshow/screen/screen_news.dart';
import 'package:eqshow/screen/screen_procurement.dart';
import 'package:eqshow/screen/screen_studies_and_research.dart';
import 'package:eqshow/screen/screen_team.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ScreenHome> {

  final gridViewItem = [
    IgtlGridItem("Recent Eartquakes", "assets/images/logo.png",const ScreenEqData()),
    // IgtlGridItem("Earthquake All Data", "assets/images/logo.png",const ScreenAllData()),
    IgtlGridItem("Studies and Research", "assets/images/logo.png",const ScreenStudiesAndResearch()),
    IgtlGridItem("News", "assets/images/logo.png",const ScreenNews()),
    IgtlGridItem("About Us", "assets/images/logo.png",const ScreenAboutUs()),
    IgtlGridItem("Annual Reports", "assets/images/logo.png",const ScreenAnnualReport()),
    IgtlGridItem("Procurements", "assets/images/logo.png",const ScreenProcurement()),
    IgtlGridItem("Team", "assets/images/logo.png",const ScreenTeam()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: renderScreen(context),),
    );
  }


  Widget renderScreen(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var topHeaderSize = screenSize.height - (screenSize.height * .75);
    var bodySize = screenSize.height - (screenSize.height * .25);
    return Stack(
      children: [
        // Stack(
        //   children: [
        //     // Container(
        //     //   width: MediaQuery.of(context).size.width,
        //     //   height: topHeaderSize,
        //     //   decoration: const BoxDecoration(
        //     //     // color: Colors.white,
        //     //   ),
        //     // ),
        //     // Container(
        //     //   width: screenSize.width,
        //     //   height: topHeaderSize,
        //     //   decoration: const BoxDecoration(
        //     //     color: Color(0xFF674AEF),
        //     //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
        //     //   ),
        //     //   child: Padding(
        //     //     padding: EdgeInsets.only(top: 200),
        //     //     child: Center(
        //     //       child: Image.asset(
        //     //         "assets/images/epicenter.png",
        //     //         width: 100,
        //     //       ),
        //     //     ),
        //     //   ),
        //     // )
        //   ],
        // ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: topHeaderSize,
          margin: EdgeInsets.zero,
          decoration: const BoxDecoration(
            color: Color(0xFF674AEF),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
            boxShadow: null,
            border: null
          ),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Image.asset(
                "assets/images/logo.png",
                width: 75,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Instituto de Geociências de Timor-Leste - Instituto Público",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1, wordSpacing: 2),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "IGTL-IP",
                  style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)),
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
                  height: topHeaderSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFF674AEF),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
                    boxShadow: null,
                    border: null,
                  )),
              Container(
                  width: screenSize.width,
                  height: bodySize,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(90)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.1),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: gridViewItem.length,
                          itemBuilder: (context, index) {
                            IgtlGridItem gridItem = gridViewItem[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => gridItem.fragment));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF674AEF),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 6
                                      )
                                    ]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(gridItem.image,height: 75,),
                                    Text(gridItem.title, style: const TextStyle(color: Colors.white),),

                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
