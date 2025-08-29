import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/model/artical_model.dart';
import 'package:news_app/views/article_web_view.dart';

class NewsTitle extends StatelessWidget {
  const NewsTitle({super.key, required this.articalModel});
  final ArticalModel articalModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (articalModel.url != null && articalModel.url!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ArticleWebView(
                    url: articalModel.url!,
                    title: articalModel.subtitle ?? '', // ابعت العنوان
                  ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: articalModel.image ?? "",
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              articalModel.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              articalModel.subtitle ?? '',
              maxLines: 2,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
