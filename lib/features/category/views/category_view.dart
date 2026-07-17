import 'package:flutter/material.dart';
import 'package:news_app/features/home/widgets/news_list_view_builder.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});

  final String category;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          category[0].toUpperCase() + category.substring(1),
          style:
              theme.appBarTheme.titleTextStyle?.copyWith(
                color: theme.colorScheme.onPrimary,
              ) ??
              theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
        ),
        surfaceTintColor: theme.colorScheme.surface.withValues(alpha: 0.0),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [NewsListViewBuilder(category: category)],
      ),
    );
  }
}
