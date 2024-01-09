import 'dart:math' show acos, asin, cos, pi, sin, sqrt;

import 'package:flutter/cupertino.dart';
//https://medium.com/nerd-for-tech/find-out-the-radius-between-two-location-points-in-flutter-9416fe2b3afa

double calculateDistance(latitude1, longitude1, latitude2, longitude2) {
  var lat1 = double.parse(latitude1);
  var lon1 = double.parse(longitude1);
  var lat2 = double.parse(latitude2);
  var lon2 = double.parse(longitude2);

  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

//https://flutteragency.com/total-distance-from-latlng-list-in-flutter/
String calculateDistanceBetween2Coordenate(latitude1, longitude1, latitude2, longitude2, String unit) {
  var lat1 = double.parse(latitude1);
  var lon1 = double.parse(longitude1);
  var lat2 = double.parse(latitude2);
  var lon2 = double.parse(longitude2);

  double theta = lon1 - lon2;
  double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
  dist = acos(dist);
  dist = rad2deg(dist);
  dist = dist * 60 * 1.1515;
  if (unit == 'K') {
    dist = dist * 1.609344;
  } else if (unit == 'N') {
    dist = dist * 0.8684;
  }
  return dist.toStringAsFixed(1);
}

double deg2rad(double deg) {
  return (deg * pi / 180.0);
}

double rad2deg(double rad) {
  return (rad * 180.0 / pi);
}


Widget getMagnitudeIcon(double magnitude) {
  String magImages = "assets/images/logo.png";
  switch(magnitude){
    case >=6.5:
      magImages="assets/images/magnitude65.png";
      break;
    case  >=6.0 && <6.5:
      magImages="assets/images/magnitude_60_64.png";
      break;
    case >=5.0 && <6.0:
      magImages="assets/images/magnitude_50_59.png";
      break;
    case <5.0:
      magImages="assets/images/magnitude_0_49.png";
      break;
  }

  return Image.asset(magImages,width: 50,);
}

Color getMagnitudeColor(double magnitude){
  Color colorMagnitude = const Color(0xFF674AEF);
  switch(magnitude){
    case >=6.5:
      colorMagnitude = const Color(0xFFFF0000);
      break;
    case  >=6.0 && <6.5:
      colorMagnitude = const Color(0xFFFF7D11);
      break;
    case >=5.0 && <6.0:
      colorMagnitude = const Color(0xFF0055BB);
      break;
    case <5.0:
      colorMagnitude = const Color(0xFF0BA14B);
      break;
  }

  return colorMagnitude;
}
