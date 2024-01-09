// To parse this JSON data, do
//
//     final momentoTensor = momentoTensorFromJson(jsonString);

import 'dart:convert';

List<MomentoTensor> momentoTensorFromJson(String str){
 return List<MomentoTensor>.from(json.decode(str).map((x) => MomentoTensor.fromJson(x)));
}

String momentoTensorToJson(List<MomentoTensor> data){
  return json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

class MomentoTensor {
  String eventId;
  String evRms;
  String evEarthmodel;
  String evMagtype;
  String evMagnitude;
  String mtDir;
  String mtType;
  String mtTensorelementsMrr;
  String mtTensorelementsMtt;
  String mtTensorelementsMpp;
  String mtTensorelementsMrt;
  String mtTensorelementsMrp;
  String mtTensorelementsMtp;
  String mtDeviatoric;
  String mtDc;
  String mtClvd;
  dynamic mtIso;
  String mtStations;
  String mtPhases;
  String mtScalar;
  String mtDoubleCouple;
  String fmMisfit;
  String fmAzimuthalGap;
  String fmNp1Strike;
  String fmNp1Dip;
  String fmNp1Rupture;
  String fmNp2Strike;
  String fmNp2Dip;
  String fmNp2Rupture;
  String fmPaNlength;
  String fmPaNazim;
  String fmPaNplunge;
  String fmPaTlength;
  String fmPaTazim;
  String fmPaTplunge;
  String fmPaPlength;
  String fmPaPazim;
  String fmPaPplunge;
  DateTime cpOriginTime;
  String cpLatitude;
  String cpLongitude;
  String cpDepth;
  String cpMethod;
  String cpEarthModel;
  String cpMagtype;
  String cpMagnitude;

  MomentoTensor({
    required this.eventId,
    required this.evRms,
    required this.evEarthmodel,
    required this.evMagtype,
    required this.evMagnitude,
    required this.mtDir,
    required this.mtType,
    required this.mtTensorelementsMrr,
    required this.mtTensorelementsMtt,
    required this.mtTensorelementsMpp,
    required this.mtTensorelementsMrt,
    required this.mtTensorelementsMrp,
    required this.mtTensorelementsMtp,
    required this.mtDeviatoric,
    required this.mtDc,
    required this.mtClvd,
    required this.mtIso,
    required this.mtStations,
    required this.mtPhases,
    required this.mtScalar,
    required this.mtDoubleCouple,
    required this.fmMisfit,
    required this.fmAzimuthalGap,
    required this.fmNp1Strike,
    required this.fmNp1Dip,
    required this.fmNp1Rupture,
    required this.fmNp2Strike,
    required this.fmNp2Dip,
    required this.fmNp2Rupture,
    required this.fmPaNlength,
    required this.fmPaNazim,
    required this.fmPaNplunge,
    required this.fmPaTlength,
    required this.fmPaTazim,
    required this.fmPaTplunge,
    required this.fmPaPlength,
    required this.fmPaPazim,
    required this.fmPaPplunge,
    required this.cpOriginTime,
    required this.cpLatitude,
    required this.cpLongitude,
    required this.cpDepth,
    required this.cpMethod,
    required this.cpEarthModel,
    required this.cpMagtype,
    required this.cpMagnitude,
  });

  factory MomentoTensor.fromJson(Map<String, dynamic> json){
    // print(json);
    json.forEach((key, value) {
      print("$key : $value ${value.runtimeType}");
    });
    return MomentoTensor(
      eventId: json["event_id"].toString(),
      evRms: json["ev_rms"].toString(),
      evEarthmodel: json["ev_earthmodel"].toString(),
      evMagtype: json["ev_magtype"].toString(),
      evMagnitude: json["ev_magnitude"].toString(),
      mtDir: json["mt_dir"].toString(),
      mtType: json["mt_type"].toString(),
      mtTensorelementsMrr: json["mt_tensorelements_Mrr"].toString(),//.toInt(),
      mtTensorelementsMtt: json["mt_tensorelements_Mtt"].toString(),//.toInt(),
      mtTensorelementsMpp: json["mt_tensorelements_Mpp"].toString(),//.toDouble(),
      mtTensorelementsMrt: json["mt_tensorelements_Mrt"].toString(),//?.toDouble(),
      mtTensorelementsMrp: json["mt_tensorelements_Mrp"].toString(),
      mtTensorelementsMtp: json["mt_tensorelements_Mtp"].toString(),//?.toDouble(),
      mtDeviatoric: json["mt_deviatoric"].toString(),
      mtDc: json["mt_dc"].toString(),
      mtClvd: json["mt_clvd"].toString(),
      mtIso: json["mt_iso"].toString(),
      mtStations: json["mt_stations"].toString(),
      mtPhases: json["mt_phases"].toString(),
      mtScalar: json["mt_scalar"].toString(),//?.toDouble(),
      mtDoubleCouple: json["mt_doubleCouple"].toString(),//?.toDouble(),
      fmMisfit: json["fm_misfit"].toString(),//?.toDouble(),
      fmAzimuthalGap: json["fm_azimuthal_gap"].toString(),
      fmNp1Strike: json["fm_np1_strike"].toString(),//?.toDouble(),
      fmNp1Dip: json["fm_np1_dip"].toString(),
      fmNp1Rupture: json["fm_np1_rupture"].toString(),//?.toDouble(),
      fmNp2Strike: json["fm_np2_strike"].toString(),//?.toDouble(),
      fmNp2Dip: json["fm_np2_dip"].toString(),//?.toDouble(),
      fmNp2Rupture: json["fm_np2_rupture"].toString(),//?.toDouble(),
      fmPaNlength: json["fm_pa_nlength"].toString(),//?.toDouble(),
      fmPaNazim: json["fm_pa_nazim"].toString(),//?.toDouble(),
      fmPaNplunge: json["fm_pa_nplunge"].toString(),//?.toDouble(),
      fmPaTlength: json["fm_pa_tlength"].toString(),//?.toDouble(),
      fmPaTazim: json["fm_pa_tazim"].toString(),//?.toDouble(),
      fmPaTplunge: json["fm_pa_tplunge"].toString(),//?.toDouble(),
      fmPaPlength: json["fm_pa_plength"].toString(),//?.toDouble(),
      fmPaPazim: json["fm_pa_pazim"].toString(),//?.toDouble(),
      fmPaPplunge: json["fm_pa_pplunge"].toString(),//?.toDouble(),
      cpOriginTime: DateTime.parse(json["cp_originTime"]),
      cpLatitude: json["cp_latitude"].toString(),//?.toDouble(),
      cpLongitude: json["cp_longitude"].toString(),//?.toDouble(),
      cpDepth: json["cp_depth"].toString(),
      cpMethod: json["cp_method"].toString(),
      cpEarthModel: json["cp_earth_model"].toString(),
      cpMagtype: json["cp_magtype"].toString(),
      cpMagnitude: json["cp_magnitude"].toString(),//?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "event_id": eventId,
    "ev_rms": evRms,
    "ev_earthmodel": evEarthmodel,
    "ev_magtype": evMagtype,
    "ev_magnitude": evMagnitude,
    "mt_dir": mtDir,
    "mt_type": mtType,
    "mt_tensorelements_Mrr": mtTensorelementsMrr,
    "mt_tensorelements_Mtt": mtTensorelementsMtt,
    "mt_tensorelements_Mpp": mtTensorelementsMpp,
    "mt_tensorelements_Mrt": mtTensorelementsMrt,
    "mt_tensorelements_Mrp": mtTensorelementsMrp,
    "mt_tensorelements_Mtp": mtTensorelementsMtp,
    "mt_deviatoric": mtDeviatoric,
    "mt_dc": mtDc,
    "mt_clvd": mtClvd,
    "mt_iso": mtIso,
    "mt_stations": mtStations,
    "mt_phases": mtPhases,
    "mt_scalar": mtScalar,
    "mt_doubleCouple": mtDoubleCouple,
    "fm_misfit": fmMisfit,
    "fm_azimuthal_gap": fmAzimuthalGap,
    "fm_np1_strike": fmNp1Strike,
    "fm_np1_dip": fmNp1Dip,
    "fm_np1_rupture": fmNp1Rupture,
    "fm_np2_strike": fmNp2Strike,
    "fm_np2_dip": fmNp2Dip,
    "fm_np2_rupture": fmNp2Rupture,
    "fm_pa_nlength": fmPaNlength,
    "fm_pa_nazim": fmPaNazim,
    "fm_pa_nplunge": fmPaNplunge,
    "fm_pa_tlength": fmPaTlength,
    "fm_pa_tazim": fmPaTazim,
    "fm_pa_tplunge": fmPaTplunge,
    "fm_pa_plength": fmPaPlength,
    "fm_pa_pazim": fmPaPazim,
    "fm_pa_pplunge": fmPaPplunge,
    "cp_originTime": cpOriginTime.toIso8601String(),
    "cp_latitude": cpLatitude,
    "cp_longitude": cpLongitude,
    "cp_depth": cpDepth,
    "cp_method": cpMethod,
    "cp_earth_model": cpEarthModel,
    "cp_magtype": cpMagtype,
    "cp_magnitude": cpMagnitude,
  };
}
