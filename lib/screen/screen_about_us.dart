import 'package:eqshow/model/wp_post_page.dart';
import 'package:eqshow/service/wp_service.dart';
import 'package:eqshow/utils/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ScreenAboutUs extends StatefulWidget {
  const ScreenAboutUs({super.key});

  @override
  State<ScreenAboutUs> createState() => _ScreenAboutUsState();
}

class _ScreenAboutUsState extends State<ScreenAboutUs> {

  final WPService _service = WPService();
  String theTitle="";
  WpPostPage? aboutUsPage;
  Future<WpPostPage> fetchData() async {
   return aboutUsPage ??= await _service.fetchAboutUs();
  }
  @override
  Widget build(BuildContext context) {
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
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(theTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15.0, color: Colors.white, letterSpacing: 1, wordSpacing: 2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: topHeaderSize),
          child: SizedBox(
              // width: screenSize.width,
              height: bodySize,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child:
                // Text(AppConstant.about_us_text,textAlign: TextAlign.justify,style: TextStyle(fontSize: 18),),
              FutureBuilder(
                future: fetchData(),
                builder: (context,snapshot){

                  if(snapshot.hasData){
                    WpPostPage? page = snapshot.data;
                    return Column(
                      children: [
                        Text(page!.title.rendered,style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.w500
                        ),),
                        Html(
                          data: page.content.rendered
                        ),
                      ],
                    );
                  }else{
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20,),
                        Text("Fetching data from IGTL")
                      ]
                      ,
                    );
                  }
                },
              )
              )
          ),
        )
      ],
    ));
  }
}
