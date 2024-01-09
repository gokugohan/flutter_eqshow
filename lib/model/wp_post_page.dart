// To parse this JSON data, do
//
//     final wpPostPage = wpPostPageFromJson(jsonString);

import 'dart:convert';

WpPostPage wpPostPageFromJson(String str) => WpPostPage.fromJson(json.decode(str));

String wpPostPageToJson(WpPostPage data) => json.encode(data.toJson());

class WpPostPage {
  int id;
  DateTime date;
  DateTime dateGmt;
  Guid guid;
  DateTime modified;
  DateTime modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Guid title;
  Content content;
  Content excerpt;
  int author;
  int featuredMedia;
  int parent;
  int menuOrder;
  String commentStatus;
  String pingStatus;
  String template;
  List<dynamic> meta;
  String yoastHead;
  YoastHeadJson yoastHeadJson;
  Links links;

  WpPostPage({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.featuredMedia,
    required this.parent,
    required this.menuOrder,
    required this.commentStatus,
    required this.pingStatus,
    required this.template,
    required this.meta,
    required this.yoastHead,
    required this.yoastHeadJson,
    required this.links,
  });

  factory WpPostPage.fromJson(Map<String, dynamic> json) => WpPostPage(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    dateGmt: DateTime.parse(json["date_gmt"]),
    guid: Guid.fromJson(json["guid"]),
    modified: DateTime.parse(json["modified"]),
    modifiedGmt: DateTime.parse(json["modified_gmt"]),
    slug: json["slug"],
    status: json["status"],
    type: json["type"],
    link: json["link"],
    title: Guid.fromJson(json["title"]),
    content: Content.fromJson(json["content"]),
    excerpt: Content.fromJson(json["excerpt"]),
    author: json["author"],
    featuredMedia: json["featured_media"],
    parent: json["parent"],
    menuOrder: json["menu_order"],
    commentStatus: json["comment_status"],
    pingStatus: json["ping_status"],
    template: json["template"],
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    yoastHead: json["yoast_head"],
    yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    "date_gmt": dateGmt.toIso8601String(),
    "guid": guid.toJson(),
    "modified": modified.toIso8601String(),
    "modified_gmt": modifiedGmt.toIso8601String(),
    "slug": slug,
    "status": status,
    "type": type,
    "link": link,
    "title": title.toJson(),
    "content": content.toJson(),
    "excerpt": excerpt.toJson(),
    "author": author,
    "featured_media": featuredMedia,
    "parent": parent,
    "menu_order": menuOrder,
    "comment_status": commentStatus,
    "ping_status": pingStatus,
    "template": template,
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "yoast_head": yoastHead,
    "yoast_head_json": yoastHeadJson.toJson(),
    "_links": links.toJson(),
  };
}

class Content {
  String rendered;
  bool protected;

  Content({
    required this.rendered,
    required this.protected,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    rendered: json["rendered"],
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
    "protected": protected,
  };
}

class Guid {
  String rendered;

  Guid({
    required this.rendered,
  });

  factory Guid.fromJson(Map<String, dynamic> json) => Guid(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}

class Links {
  List<About> self;
  List<About> collection;
  List<About> about;
  List<Author> author;
  List<Author> replies;
  List<VersionHistory> versionHistory;
  List<PredecessorVersion> predecessorVersion;
  List<About> wpAttachment;
  List<Cury> curies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.author,
    required this.replies,
    required this.versionHistory,
    required this.predecessorVersion,
    required this.wpAttachment,
    required this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    author: List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
    replies: List<Author>.from(json["replies"].map((x) => Author.fromJson(x))),
    versionHistory: List<VersionHistory>.from(json["version-history"].map((x) => VersionHistory.fromJson(x))),
    predecessorVersion: List<PredecessorVersion>.from(json["predecessor-version"].map((x) => PredecessorVersion.fromJson(x))),
    wpAttachment: List<About>.from(json["wp:attachment"].map((x) => About.fromJson(x))),
    curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "author": List<dynamic>.from(author.map((x) => x.toJson())),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "version-history": List<dynamic>.from(versionHistory.map((x) => x.toJson())),
    "predecessor-version": List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
    "wp:attachment": List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
    "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
  };
}

class About {
  String href;

  About({
    required this.href,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Author {
  bool embeddable;
  String href;

  Author({
    required this.embeddable,
    required this.href,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "href": href,
  };
}

class Cury {
  String name;
  String href;
  bool templated;

  Cury({
    required this.name,
    required this.href,
    required this.templated,
  });

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
    name: json["name"],
    href: json["href"],
    templated: json["templated"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "href": href,
    "templated": templated,
  };
}

class PredecessorVersion {
  int id;
  String href;

  PredecessorVersion({
    required this.id,
    required this.href,
  });

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) => PredecessorVersion(
    id: json["id"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "href": href,
  };
}

class VersionHistory {
  int count;
  String href;

  VersionHistory({
    required this.count,
    required this.href,
  });

  factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
    count: json["count"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "href": href,
  };
}

class YoastHeadJson {
  String title;
  Robots robots;
  String canonical;
  String ogLocale;
  String ogType;
  String ogTitle;
  String ogDescription;
  String ogUrl;
  String ogSiteName;
  DateTime articleModifiedTime;
  TwitterMisc twitterMisc;
  Schema schema;

  YoastHeadJson({
    required this.title,
    required this.robots,
    required this.canonical,
    required this.ogLocale,
    required this.ogType,
    required this.ogTitle,
    required this.ogDescription,
    required this.ogUrl,
    required this.ogSiteName,
    required this.articleModifiedTime,
    required this.twitterMisc,
    required this.schema,
  });

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
    title: json["title"],
    robots: Robots.fromJson(json["robots"]),
    canonical: json["canonical"],
    ogLocale: json["og_locale"],
    ogType: json["og_type"],
    ogTitle: json["og_title"],
    ogDescription: json["og_description"],
    ogUrl: json["og_url"],
    ogSiteName: json["og_site_name"],
    articleModifiedTime: DateTime.parse(json["article_modified_time"]),
    twitterMisc: TwitterMisc.fromJson(json["twitter_misc"]),
    schema: Schema.fromJson(json["schema"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "robots": robots.toJson(),
    "canonical": canonical,
    "og_locale": ogLocale,
    "og_type": ogType,
    "og_title": ogTitle,
    "og_description": ogDescription,
    "og_url": ogUrl,
    "og_site_name": ogSiteName,
    "article_modified_time": articleModifiedTime.toIso8601String(),
    "twitter_misc": twitterMisc.toJson(),
    "schema": schema.toJson(),
  };
}

class Robots {
  String index;
  String follow;
  String maxSnippet;
  String maxImagePreview;
  String maxVideoPreview;

  Robots({
    required this.index,
    required this.follow,
    required this.maxSnippet,
    required this.maxImagePreview,
    required this.maxVideoPreview,
  });

  factory Robots.fromJson(Map<String, dynamic> json) => Robots(
    index: json["index"],
    follow: json["follow"],
    maxSnippet: json["max-snippet"],
    maxImagePreview: json["max-image-preview"],
    maxVideoPreview: json["max-video-preview"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "follow": follow,
    "max-snippet": maxSnippet,
    "max-image-preview": maxImagePreview,
    "max-video-preview": maxVideoPreview,
  };
}

class Schema {
  String context;
  List<Graph> graph;

  Schema({
    required this.context,
    required this.graph,
  });

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
    context: json["@context"],
    graph: List<Graph>.from(json["@graph"].map((x) => Graph.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "@context": context,
    "@graph": List<dynamic>.from(graph.map((x) => x.toJson())),
  };
}

class Graph {
  String type;
  String id;
  String? url;
  String? name;
  Breadcrumb? isPartOf;
  DateTime? datePublished;
  DateTime? dateModified;
  Breadcrumb? breadcrumb;
  String? inLanguage;
  List<PotentialAction>? potentialAction;
  List<ItemListElement>? itemListElement;
  String? description;

  Graph({
    required this.type,
    required this.id,
    this.url,
    this.name,
    this.isPartOf,
    this.datePublished,
    this.dateModified,
    this.breadcrumb,
    this.inLanguage,
    this.potentialAction,
    this.itemListElement,
    this.description,
  });

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
    type: json["@type"],
    id: json["@id"],
    url: json["url"],
    name: json["name"],
    isPartOf: json["isPartOf"] == null ? null : Breadcrumb.fromJson(json["isPartOf"]),
    datePublished: json["datePublished"] == null ? null : DateTime.parse(json["datePublished"]),
    dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
    breadcrumb: json["breadcrumb"] == null ? null : Breadcrumb.fromJson(json["breadcrumb"]),
    inLanguage: json["inLanguage"],
    potentialAction: json["potentialAction"] == null ? [] : List<PotentialAction>.from(json["potentialAction"]!.map((x) => PotentialAction.fromJson(x))),
    itemListElement: json["itemListElement"] == null ? [] : List<ItemListElement>.from(json["itemListElement"]!.map((x) => ItemListElement.fromJson(x))),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "@id": id,
    "url": url,
    "name": name,
    "isPartOf": isPartOf?.toJson(),
    "datePublished": datePublished?.toIso8601String(),
    "dateModified": dateModified?.toIso8601String(),
    "breadcrumb": breadcrumb?.toJson(),
    "inLanguage": inLanguage,
    "potentialAction": potentialAction == null ? [] : List<dynamic>.from(potentialAction!.map((x) => x.toJson())),
    "itemListElement": itemListElement == null ? [] : List<dynamic>.from(itemListElement!.map((x) => x.toJson())),
    "description": description,
  };
}

class Breadcrumb {
  String id;

  Breadcrumb({
    required this.id,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
    id: json["@id"],
  );

  Map<String, dynamic> toJson() => {
    "@id": id,
  };
}

class ItemListElement {
  String type;
  int position;
  String name;
  String? item;

  ItemListElement({
    required this.type,
    required this.position,
    required this.name,
    this.item,
  });

  factory ItemListElement.fromJson(Map<String, dynamic> json) => ItemListElement(
    type: json["@type"],
    position: json["position"],
    name: json["name"],
    item: json["item"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "position": position,
    "name": name,
    "item": item,
  };
}

class PotentialAction {
  String type;
  dynamic target;
  String? queryInput;

  PotentialAction({
    required this.type,
    required this.target,
    this.queryInput,
  });

  factory PotentialAction.fromJson(Map<String, dynamic> json) => PotentialAction(
    type: json["@type"],
    target: json["target"],
    queryInput: json["query-input"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "target": target,
    "query-input": queryInput,
  };
}

class TargetClass {
  String type;
  String urlTemplate;

  TargetClass({
    required this.type,
    required this.urlTemplate,
  });

  factory TargetClass.fromJson(Map<String, dynamic> json) => TargetClass(
    type: json["@type"],
    urlTemplate: json["urlTemplate"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "urlTemplate": urlTemplate,
  };
}

class TwitterMisc {
  String estReadingTime;

  TwitterMisc({
    required this.estReadingTime,
  });

  factory TwitterMisc.fromJson(Map<String, dynamic> json) => TwitterMisc(
    estReadingTime: json["Est. reading time"],
  );

  Map<String, dynamic> toJson() => {
    "Est. reading time": estReadingTime,
  };
}
