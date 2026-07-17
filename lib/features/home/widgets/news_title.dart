import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:news_app/features/favorite/cubit/favorite_states.dart';
import 'package:news_app/core/navigation/app_routes.dart';
import 'package:news_app/core/navigation/navigation_helpers.dart';

class NewsTitle extends StatelessWidget {
  const NewsTitle({super.key, required this.articleModel});
  final ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (articleModel.url != null && articleModel.url!.isNotEmpty) {
          context.pushNamed(
            AppRoutes.articleWebView,
            arguments: {
              'url': articleModel.url!,
              'title': articleModel.subtitle ?? '',
            },
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LayoutBuilder(
              builder: (context, constraints) {
                final imageHeight =
                    (constraints.maxWidth > 600 ? 240.0 : 200.0);

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: articleModel.image ?? "",
                        height: imageHeight,
                        width: constraints.maxWidth,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Container(
                              height: imageHeight,
                              color: theme.colorScheme.surfaceContainerHighest,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Container(
                              height: imageHeight,
                              color: theme.colorScheme.surfaceContainerHighest,
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                      ),
                    ),

                    Positioned(
                      top: 10,
                      right: 10,
                      child: BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, state) {
                          final cubit = context.read<FavoriteCubit>();
                          final isFav = cubit.isFavorite(articleModel);

                          return CircleAvatar(
                            backgroundColor: theme.cardColor,
                            child: IconButton(
                              onPressed: () {
                                if (isFav) {
                                  cubit.removeFavorite(articleModel);
                                } else {
                                  cubit.addFavorite(articleModel);
                                }
                              },
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: theme.colorScheme.error,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 12),
            Text(
              articleModel.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: theme.textTheme.titleLarge?.color,
                fontSize: MediaQuery.sizeOf(context).width < 360 ? 17 : 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              articleModel.subtitle ?? '',
              maxLines: 2,
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color,
                fontSize: MediaQuery.sizeOf(context).width < 360 ? 13 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
