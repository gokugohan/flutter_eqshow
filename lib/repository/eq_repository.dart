import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/model/evento.dart';
import 'package:eqshow/model/moment_tensor.dart';
import 'package:http/http.dart' as http;

class EqRepository {

  Future<Evento?> fetchData(String url) async {
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Evento evento = eventoFromJson(const Utf8Decoder().convert(response.bodyBytes));
        return evento;
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      return null;
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return null;
    } on Error catch (e) {
      print('General Error: $e');
      return null;
    }
    throw Exception('Errorrrrrrrrrrrr');
  }

  Future<List<MomentoTensor>?> fetchMomentTensor(String eventId) async {
    String url = "http://geohazard.igtl.tl:83/api/mt/id/$eventId";
    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return momentoTensorFromJson(const Utf8Decoder().convert(response.bodyBytes));
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      return null;
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return null;
    } on Error catch (e) {
      print('General Error: $e');
      return null;
    }
    throw Exception('Errorrrrrrrrrrrr');
  }


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
