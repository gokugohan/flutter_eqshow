import 'package:flutter/material.dart';

class ScreenStudiesAndResearch extends StatefulWidget {
  const ScreenStudiesAndResearch({super.key});

  @override
  State<ScreenStudiesAndResearch> createState() => _ScreenStudiesAndResearchState();
}

class _ScreenStudiesAndResearchState extends State<ScreenStudiesAndResearch> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var topHeaderSize = screenSize.height - (screenSize.height * .75);
    var bodySize = screenSize.height - (screenSize.height * .25);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Studies and Research"),
          elevation: 0,
          backgroundColor: const Color(0xFF674AEF),
        ),
        body:
        Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: topHeaderSize,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: topHeaderSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFF674AEF),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 100,
                    ),
                  ),
                )
              ],
            ),
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
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "IGTL-IP",
                      style: TextStyle(fontSize: 23, color: Colors.white.withOpacity(0.6)),
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
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(90))
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
                            Container(
                              color: Colors.red,
                              child: const Text("Result of igtl api reuest to studies and research categories container\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "dasd\n"
                                  "Hello world\n"
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}