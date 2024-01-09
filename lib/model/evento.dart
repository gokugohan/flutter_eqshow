// To parse this JSON data, do
//
//     final evento = eventoFromJson(jsonString);

import 'dart:convert';

Evento eventoFromJson(String str){
  // print(str);
  return Evento.fromJson(json.decode(str));
}

String eventoToJson(Evento data){
  return json.encode(data.toJson());
}

class Evento {
  int currentPage;
  List<Datum> data;
  String? nextPageUrl;
  String perPage;
  int total;

  Evento({
    required this.currentPage,
    required this.data,
    required this.nextPageUrl,
    required this.perPage,
    required this.total,
  });

  factory Evento.fromJson(Map<String, dynamic> json){
    Evento evento = Evento(
      currentPage: json["current_page"],
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      perPage: json["per_page"],
      total: json["total"],
    );

   return evento;
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "per_page": perPage,
    "total": total,
  };
}

class Datum {
  String eventId;
  String latitude;
  String longitude;
  String magnitude;
  String depth;
  DateTime eventDatetime;
  String region;
  // MagType magType;
  String phaseArrivals;
  String magRes;
  String magStations;
  // Status status;
  double distanceToCenterPoint;
  String hasSigma;
  String hasMt;
  String sigmaDir;

  Datum({
    required this.eventId,
    required this.latitude,
    required this.longitude,
    required this.magnitude,
    required this.depth,
    required this.eventDatetime,
    required this.region,
    // required this.magType,
    required this.phaseArrivals,
    required this.magRes,
    required this.magStations,
    // required this.status,
    required this.distanceToCenterPoint,
    required this.hasSigma,
    required this.hasMt,
    required this.sigmaDir,
  });

  factory Datum.fromJson(Map<String, dynamic> json){
    Datum datum = Datum(
      eventId: json["event_id"].toString(),
      latitude: json["latitude"].toString(),
      longitude: json["longitude"].toString(),
      magnitude: json["magnitude"].toString(),
      depth: json["depth"].toString(),
      eventDatetime: DateTime.parse(json["event_datetime"]),
      region: json["region"].toString(),
      // magType: magTypeValues.map[json["mag_type"].toString()]!,
      phaseArrivals: json["phase_arrivals"].toString(),
      magRes: json["mag_res"].toString(),
      magStations: json["mag_stations"].toString(),
      // status: statusValues.map[json["status"].toString()]!,
      distanceToCenterPoint: json["distance_to_center_point"]?.toDouble(),
      hasSigma: json["has_sigma"].toString(),
      hasMt: json["has_mt"].toString(),
      sigmaDir: json["sigma_dir"].toString(),
    );

    return datum;
  }

  Map<String, dynamic> toJson() => {
    "event_id": eventId,
    "latitude": latitude,
    "longitude": longitude,
    "magnitude": magnitude,
    "depth": depth,
    "event_datetime": eventDatetime.toIso8601String(),
    "region": region,
    // "mag_type": magTypeValues.reverse[magType],
    "phase_arrivals": phaseArrivals,
    "mag_res": magRes,
    "mag_stations": magStations,
    // "status": statusValues.reverse[status],
    "distance_to_center_point": distanceToCenterPoint,
    "has_sigma": hasSigma,
    "has_mt": hasMt,
    "sigma_dir": sigmaDir,
  };
}

enum MagType {
  M,
  MW_M_B
}

final magTypeValues = EnumValues({
  "M": MagType.M,
  "Mw(mB)": MagType.MW_M_B
});

enum Status {
  A,
  M
}

final statusValues = EnumValues({
  "a": Status.A,
  "m": Status.M
});

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
