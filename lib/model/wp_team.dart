import 'dart:convert';

List<WPTeam> teamFromJson(String str) => List<WPTeam>.from(json.decode(str).map((x) => WPTeam.fromJson(x)));

String teamToJson(List<WPTeam> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WPTeam {
  String name;
  String degree;
  String position;
  String avatar;

  WPTeam({
    required this.name,
    required this.degree,
    required this.position,
    required this.avatar,
  });

  factory WPTeam.fromJson(Map<String, dynamic> json) => WPTeam(
    name: json["name"],
    degree: json["degree"],
    position: json["position"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "degree": degree,
    "position": position,
    "avatar": avatar,
  };
}
