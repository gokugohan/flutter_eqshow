import 'package:dotted_border/dotted_border.dart';
import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/model/wp_post.dart';
import 'package:eqshow/utils/EqUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:timeago/timeago.dart' as timeago;

class ScreenNewsDetails extends StatefulWidget {
  ScreenNewsDetails({super.key, required this.model});

  final WpPost model;

  @override
  State<ScreenNewsDetails> createState() => _ScreenNewsDetailsState();
}

class _ScreenNewsDetailsState extends State<ScreenNewsDetails> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var topHeaderSize = screenSize.height - (screenSize.height * .80);
    var bodySize = screenSize.height - (screenSize.height * .20);

    Orientation orientation = MediaQuery.of(context).orientation;
    DateTime? eventDateTime = widget.model.date;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF674AEF),
        elevation: 0,
        title: Text("${widget.model.title}"),
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
                    widget.model.title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: topHeaderSize),
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
                    child: Html(data: widget.model.link.toString()),
                  ),
                )
              ],
            ),
          ),

        ],
      ),

    );
  }

}

