import 'package:hive/hive.dart';

part 'article_model.g.dart';

// The Hive model metadata must be declared here so the generated adapter can
// serialize the article fields correctly for local caching.
@HiveType(typeId: 0)
class ArticleModel {
  @HiveField(0)
  final String? image;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? subtitle;
  @HiveField(3)
  final String? url;

  ArticleModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {'image': image, 'title': title, 'subtitle': subtitle, 'url': url};
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      image: json['image'],
      title: json['title'],
      subtitle: json['subtitle'],
      url: json['url'],
    );
  }
}
