import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/model/article_Model.dart';

class ArticleView extends StatelessWidget {
  Article articleModel;

  ArticleView(this.articleModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //     ClipRRect(child:
          //      CachedNetworkImage(
          //        imageUrl: articleModel.urlToImage ?? "",
          //           placeholder: (context, url) => CircularProgressIndicator(),
          //        errorWidget: (context, url, error) => Icon(Icons.error),
          // ),
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(articleModel.urlToImage ?? "")),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              articleModel.source?.name ?? "",
              style: const TextStyle(
                color: Color(0xff79828B),
                fontSize: 10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              articleModel.title ?? "",
              style: const TextStyle(
                color: Color(0xff42505C),
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              articleModel.publishedAt ?? "",
              style: const TextStyle(
                color: Color(0xffA3A3A3),
                fontSize: 13,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
