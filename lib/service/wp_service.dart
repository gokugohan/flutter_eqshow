
import 'package:eqshow/model/wp_post_page.dart';
import 'package:eqshow/repository/igtl_wp_repository.dart';

class WPService {
  final repository = IgtlWpRepository();

  Future<WpPostPage> fetchAboutUs() async {
    return await repository.fetchAboutUs();
  }

  Future<List> fethStudiesAndResearch() async {
    return await repository.fethStudiesAndResearch();
  }

  Future<List> fetchTeam() async {
    return await repository.fetchTeam();
  }
  Future<List> fetchCategories() async {
    return await repository.fetchCategories();
  }

  Future<List> fetchPostByCategories(categoryId) async {
    return await repository.fetchPostByCategories(categoryId);
  }

}
