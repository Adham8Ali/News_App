import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/cubit/news_states.dart';
import 'package:news_app/features/home/data/news_data_source.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsDataSource newsServices;

  NewsCubit(this.newsServices) : super(NewsInitial());

  Future<void> getNews(String category) async {
    emit(NewsLoading());

    try {
      final news = await newsServices.getNews(category: category);
      emit(NewsSuccess(news));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
