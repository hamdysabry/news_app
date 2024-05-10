import 'package:flutter/material.dart';
import 'package:news_app/Shared_component/network/api_manger.dart';
import 'package:news_app/model/article_Model.dart';
import 'package:news_app/pages/widgets/article_view.dart';

class ArticlsListView extends StatelessWidget {
  String sourceId;

  ArticlsListView(this.sourceId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticleModel>(
      future: ApiManger.fetchNews(sourceId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              Text("${snapshot.error}"),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.refresh_outlined))
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var articlList = snapshot.data?.articles ?? [];
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ArticleView(articlList[index]);
              },
              itemCount: articlList.length,
            ),
          );
        }
      },
    );
  }
}
