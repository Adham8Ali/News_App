import 'package:flutter/material.dart';
import 'package:news_app/features/category/widgets/category_list_view.dart';
import 'package:news_app/features/home/widgets/news_list_view_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final titleFontSize = screenWidth < 360 ? 20.0 : 22.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: theme.colorScheme.surface.withValues(alpha: 0.0),
        backgroundColor: theme.colorScheme.primary,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "News ",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              TextSpan(
                text: "App",
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CategoriesListView()),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            NewsListViewBuilder(category: 'general'),
          ],
        ),
      ),
    );
  }
}
