import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eqshow/model/eq_event.dart';
import 'package:http/http.dart' as http;

class EqRepository {
  Future<List<EqEvent>?> fetchAllEventListApi() async {
    String url = "http://geohazard.igtl.tl:83/api/events/";

    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return eqEventFromJson(const Utf8Decoder().convert(response.bodyBytes));
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      return [];
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return [];
    } on Error catch (e) {
      print('General Error: $e');
      return [];
    }
    throw Exception('Error');
  }

  Future<List<EqEvent>?> fetchEventListApi(int limit) async {
    String url = "http://geohazard.igtl.tl:83/api/events/radius/950/limit/$limit";

    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return eqEventFromJson(const Utf8Decoder().convert(response.bodyBytes));
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      return [];
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return [];
    } on Error catch (e) {
      print('General Error: $e');
      return [];
    }
    throw Exception('Error');
  }


  Future<List<EqEvent>?> fetchEventListInRadiusApi(double radius) async {
    String url = "http://geohazard.igtl.tl:83/api/events/radius/$radius/limit/10";

    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return eqEventFromJson(const Utf8Decoder().convert(response.bodyBytes));
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      return [];
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return [];
    } on Error catch (e) {
      print('General Error: $e');
      return [];
    }
    throw Exception('Error');
  }

}
