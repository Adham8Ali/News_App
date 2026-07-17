import 'package:hive/hive.dart';
import 'package:news_app/core/models/article_model.dart';

class HiveService {
  static const String _boxName = 'newsBox';

  Future<Box<ArticleModel>> _openNewsBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<ArticleModel>(_boxName);
    }
    return Hive.box<ArticleModel>(_boxName);
  }

  Future<void> saveNews(String category, List<ArticleModel> news) async {
    final box = await _openNewsBox();

    // امسح الكاش الخاص بالكاتيجوري دي فقط
    final oldKeys =
        box.keys
            .where((key) => key.toString().startsWith('${category}_'))
            .toList();

    await box.deleteAll(oldKeys);

    final Map<String, ArticleModel> entries = {};

    for (int i = 0; i < news.length; i++) {
      entries['${category}_$i'] = news[i];
    }

    await box.putAll(entries);
  }

  Future<List<ArticleModel>> getNews(String category) async {
    final box = await _openNewsBox();

    final articles =
        box.keys
            .where((key) => key.toString().startsWith('${category}_'))
            .map((key) => box.get(key))
            .whereType<ArticleModel>()
            .toList();

    return articles;
  }

  Future<void> clearNews(String category) async {
    final box = await _openNewsBox();

    final keys =
        box.keys
            .where((key) => key.toString().startsWith('${category}_'))
            .toList();

    await box.deleteAll(keys);
  }
}
