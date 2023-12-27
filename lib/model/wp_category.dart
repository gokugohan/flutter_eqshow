import 'dart:convert';

List<WpCategory> wpCategoryFromJson(String str){
  return List<WpCategory>.from(json.decode(str).map((x)=>WpCategory.fromJson(x)));
}


class WpCategory{
  int? id;
  String? name;
  String? slug;
  String? taxonomy;
  String? link;

  WpCategory({this.id,this.name,this.slug,this.taxonomy,this.link});


  WpCategory.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    taxonomy = json['taxonomy'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['taxonomy'] = taxonomy;
    data['link'] = link;
    return data;
  }

}

