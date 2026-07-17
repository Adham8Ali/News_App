import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:news_app/features/favorite/cubit/favorite_states.dart';
import 'package:news_app/features/home/widgets/news_title.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final titleFontSize = screenWidth < 360 ? 18.0 : 22.0;

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
                text: "Favorite ",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              TextSpan(
                text: "Articles",
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            final cubit = context.read<FavoriteCubit>();

            if (state is FavoriteLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              );
            }

            if (cubit.favorites.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 90,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "No favorites yet",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: screenWidth < 360 ? 18 : 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Add articles you like ❤️",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: cubit.favorites.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: NewsTitle(articleModel: cubit.favorites[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
