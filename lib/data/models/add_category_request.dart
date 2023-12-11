import 'dart:convert';

class AddCategoryRequest {
  final String name;
  final String image;

  AddCategoryRequest({
    required this.name,
    required this.image,
  });

  factory AddCategoryRequest.fromJson(String str) =>
      AddCategoryRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCategoryRequest.fromMap(Map<String, dynamic> json) =>
      AddCategoryRequest(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "image": image,
      };
}
