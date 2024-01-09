import 'dart:convert';

List<WpPost> wpPostFromJson(String str){
  return List<WpPost>.from(json.decode(str).map((x)=>WpPost.fromJson(x)));
}


class WpPost{
  int? id;
  String? title;
  String? link;
  String? slug;
  String? content;
  DateTime? date;

  WpPost({this.id,this.title,this.slug,this.content,this.link,this.date});


  WpPost.fromJson(Map<String, dynamic> json) {


    id = json['id'];
    title = json['title']['rendered'];
    link = json['link'];
    slug = json['slug'];
    content = json['content']['rendered'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['link'] = link;
    data['slug'] = slug;
    data['content'] = content;
    data['date'] = date;
    return data;
  }

}

