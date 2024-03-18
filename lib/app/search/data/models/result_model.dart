import 'dart:convert';

import 'package:github_search/app/search/domain/entities/result.dart';

class ResultModel extends Result {
  const ResultModel({
    required super.image,
    required super.name,
    required super.nickname,
    required super.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'nickname': nickname,
      'url': url,
    };
  }

  static ResultModel fromMap(Map<String, dynamic> map) {
    return ResultModel(
      image: map['image'],
      name: map['name'],
      nickname: map['nickname'],
      url: map['url'],
    );
  }

  String toJson() => toMap().toString();

  static ResultModel fromJson(String source) => fromMap(jsonDecode(source));
}
