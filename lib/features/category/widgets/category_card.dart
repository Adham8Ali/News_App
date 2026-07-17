import 'package:flutter/material.dart';
import 'package:news_app/features/category/models/category_model.dart';
import 'package:news_app/core/navigation/app_routes.dart';
import 'package:news_app/core/navigation/navigation_helpers.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardHeight = (screenWidth * 0.32).clamp(140.0, 220.0);
    final cardWidth = (screenWidth * 0.38).clamp(140.0, 180.0);

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.categoryView,
          arguments: category.categoryName,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 8, left: 5),
        child: Container(
          height: cardHeight,
          width: cardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(category.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                category.categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: screenWidth < 360 ? 14 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
