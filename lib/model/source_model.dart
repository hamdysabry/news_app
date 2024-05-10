class SourceModel {
  String? status;
  String? code;
  String? message;
  List<Source>? sources;

  SourceModel({this.status, this.code, this.message, this.sources});

  // factory SourceModel.fromJson(Map<String, dynamic> json) {
  //   return SourceModel(
  //       status: json["status"],
  //       code: json["code"] ?? "",
  //       message: json["message"] ?? "",
  //       sources: List<Source>.from(
  //           json["sourse"].map((elements) => Source.fromJson(elements))
  //       )
  //   );
  // }
  SourceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json["message"];
    if (json['sources'] != null) {
      sources = <Source>[];
      json['sources'].forEach((v) {
        sources!.add(new Source.fromJson(v));
      });
    }
  }
}

class Source {
  String? id;
  String? name;
  String? description;
  String? category;

  Source({this.id, this.name, this.description, this.category});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        category: json["category"]);
  }
}
