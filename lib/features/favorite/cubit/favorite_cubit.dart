import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/features/favorite/cubit/favorite_states.dart';
import 'package:news_app/features/favorite/data/favorite_data_source.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteDataSource dataSource;

  FavoriteCubit(this.dataSource) : super(FavoriteInitial());

  List<ArticleModel> favorites = [];

  Future<void> getFavorites() async {
    emit(FavoriteLoading());

    try {
      favorites = await dataSource.getUserFavorites();

      emit(FavoritesUpdated(List.from(favorites)));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> addFavorite(ArticleModel article) async {
    try {
      await dataSource.addToFavorite(article);

      favorites.add(article);

      emit(FavoritesUpdated(List.from(favorites)));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> removeFavorite(ArticleModel article) async {
    try {
      await dataSource.removeFromFavorite(article);

      favorites.removeWhere((e) => e.url == article.url);

      emit(FavoritesUpdated(List.from(favorites)));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  bool isFavorite(ArticleModel article) {
    return favorites.any((e) => e.url == article.url);
  }
}
