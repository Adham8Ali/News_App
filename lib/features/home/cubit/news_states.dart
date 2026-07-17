import 'package:news_app/core/models/article_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<ArticleModel> articles;

  NewsSuccess(this.articles);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
