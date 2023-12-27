

import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/model/wp_category.dart';
import 'package:eqshow/repository/eq_repository.dart';
import 'package:eqshow/repository/igtl_wp_repository.dart';

class WPService {
  final repository = IgtlWpRepository();

  Future<List> fetchCategories() async {
    return await repository.fetchCategories();
  }

  Future<List> fetchPostByCategories(categoryId) async {
    return await repository.fetchPostByCategories(categoryId);
  }

}
