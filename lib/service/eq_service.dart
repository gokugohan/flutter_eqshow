

import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/repository/eq_repository.dart';

class EqService {
  final repository = EqRepository();

  Future<List<EqEvent>?> fetchAllEventListApi() async {
    return await repository.fetchAllEventListApi();
  }

  Future<List<EqEvent>?> fetchEventListApi(int limit) async {
    return await repository.fetchEventListApi(limit);
  }
  Future<List<EqEvent>?> fetchEventListInRadiusApi(double radius) async {
    return await repository.fetchEventListInRadiusApi(radius);
  }
}
