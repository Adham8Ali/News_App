import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/artical_model.dart';
import 'package:news_app/services/new_services.dart';
import 'package:news_app/widgets/news_list_view.dart';

class NewListViewBulider extends StatefulWidget {
  const NewListViewBulider({super.key, required this.category});

  final String category;

  @override
  State<NewListViewBulider> createState() => _NewListViewBuliderState();
}

var future;

class _NewListViewBuliderState extends State<NewListViewBulider> {
  void initState() {
    super.initState();
    future = NewServices(Dio()).getNews(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticalModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewListView(articals: snapshot.data ?? []);
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,

              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            ),
          );
        }
      },
    );
  }
}
