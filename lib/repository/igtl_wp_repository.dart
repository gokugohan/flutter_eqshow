import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eqshow/model/wp_category.dart';
import 'package:eqshow/model/wp_post.dart';
import 'package:eqshow/model/wp_post_page.dart';
import 'package:http/http.dart' as http;

class IgtlWpRepository {

  Future<WpPostPage> fetchAboutUs() async{

    String url = "http://igtl.tl/wp-json/wp/v2/pages/1444";

    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return wpPostPageFromJson(const Utf8Decoder().convert(response.bodyBytes));
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
    throw Exception('Error');
  }
  Future<List> fetchTeam() async {
    String url = "http://igtl.tl//wp-json/wp/v2/categories";

    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return wpCategoryFromJson(const Utf8Decoder().convert(response.bodyBytes));
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

  Future<List> fethStudiesAndResearch() async {
    String url = "http://igtl.tl//wp-json/wp/v2/studies-and-research";

    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return wpPostFromJson(const Utf8Decoder().convert(response.bodyBytes));
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

  Future<List> fetchCategories() async {
    String url = "http://igtl.tl//wp-json/wp/v2/categories";

    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return wpCategoryFromJson(const Utf8Decoder().convert(response.bodyBytes));
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


  Future<List> fetchPostByCategories(categoryId) async {
    String url = "http://igtl.tl//wp-json/wp/v2/posts?categories=$categoryId&per_page=50";

    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return wpPostFromJson(const Utf8Decoder().convert(response.bodyBytes));
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
