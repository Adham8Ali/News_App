import 'package:dio/dio.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/services/hive_service.dart';

class NewsDataSource {
  final Dio dio;
  final HiveService hiveService;

  NewsDataSource(this.dio, {HiveService? hiveService})
    : hiveService = hiveService ?? HiveService();

  Future<List<ArticleModel>> getNews({required String category}) async {
    try {
      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=ede7615b802845b5930f8fc2eef69bae',
      );

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> articles = jsonData['articles'];

      List<ArticleModel> articleList = [];

      for (var article in articles) {
        articleList.add(
          ArticleModel(
            image: article['urlToImage'] ?? '',
            title: article['title'] ?? '',
            subtitle: article['description'] ?? '',
            url: article['url'] ?? '',
          ),
        );
      }

      // حفظ أخبار الكاتيجوري الحالية
      await hiveService.saveNews(category, articleList);

      return articleList;
    } catch (e) {
      // لو الإنترنت وقع
      return await hiveService.getNews(category);
    }
  }
}
