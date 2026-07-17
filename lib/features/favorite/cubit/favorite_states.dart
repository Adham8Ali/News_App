import 'package:news_app/core/models/article_model.dart';

sealed class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoritesUpdated extends FavoriteState {
  final List<ArticleModel> favorites;

  FavoritesUpdated(this.favorites);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}
