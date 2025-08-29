import 'package:flutter/material.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/views/categary_view.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CategoryView(category: category.categoryName);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 8, left: 5),
        child: Container(
          height: 250,
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(category.image),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Text(
              category.categoryName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
