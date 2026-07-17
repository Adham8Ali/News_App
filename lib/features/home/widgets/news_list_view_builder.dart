import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/cubit/news_cubit.dart';
import 'package:news_app/features/home/cubit/news_states.dart';
import 'package:news_app/features/home/widgets/news_list_view.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});

  final String category;

  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<NewsCubit>().getNews(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state is NewsSuccess) {
          return NewsListView(articles: state.articles);
        }

        if (state is NewsError) {
          return SliverToBoxAdapter(child: Center(child: Text(state.message)));
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
