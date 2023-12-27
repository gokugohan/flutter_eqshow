import 'dart:convert';

List<EqEvent> eqEventFromJson(String str){
  return List<EqEvent>.from(json.decode(str).map((x)=>
      EqEvent.fromJson(x )));
}


class EqEvent {
  String? eventId;
  String? latitude;
  String? longitude;
  String? magnitude;
  int? depth;
  String? eventDatetime;
  String? region;
  String? magType;
  int? phaseArrivals;
  String? magRes;
  int? magStations;
  String? status;
  double? distanceToCenterPoint;
  int? hasSigma;
  int? hasMt;
  String? sigmaDir;


  EqEvent(
      {this.eventId,
        this.latitude,
        this.longitude,
        this.magnitude,
        this.depth,
        this.eventDatetime,
        this.region,
        this.magType,
        this.phaseArrivals,
        this.magRes,
        this.magStations,
        this.status,
        this.distanceToCenterPoint,
        this.hasSigma,
        this.hasMt,
        this.sigmaDir});


  EqEvent.fromJson(Map<String, dynamic> json) {

    eventId = json['event_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    magnitude = json['magnitude'];
    depth = json['depth'];
    eventDatetime = json['event_datetime'];
    region = json['region'];
    magType = json['mag_type'];
    phaseArrivals = json['phase_arrivals'];
    magRes = json['mag_res'];
    magStations = json['mag_stations'];
    status = json['status'];
    distanceToCenterPoint = json['distance_to_center_point'];
    hasSigma = json['has_sigma'];
    hasMt = json['has_mt'];
    sigmaDir = json['sigma_dir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['magnitude'] = magnitude;
    data['depth'] = depth;
    data['event_datetime'] = eventDatetime;
    data['region'] = region;
    data['mag_type'] = magType;
    data['phase_arrivals'] = phaseArrivals;
    data['mag_res'] = magRes;
    data['mag_stations'] = magStations;
    data['status'] = status;
    data['distance_to_center_point'] = distanceToCenterPoint;
    data['has_sigma'] = hasSigma;
    data['has_mt'] = hasMt;
    data['sigma_dir'] = sigmaDir;
    return data;
  }
}