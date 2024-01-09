

import 'package:eqshow/model/eq_event.dart';
import 'package:eqshow/model/evento.dart';
import 'package:eqshow/model/moment_tensor.dart';
import 'package:eqshow/repository/eq_repository.dart';

class EqService {
  final repository = EqRepository();

  Future<Evento?> fetchData(String url) async {
    return await repository.fetchData(url);
  }

  Future<List<MomentoTensor>?> fetchMomentTensor(String eventId) async {
    return await repository.fetchMomentTensor(eventId);
  }

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
