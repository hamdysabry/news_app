import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Shared_component/network/api_manger.dart';
import 'package:news_app/model/categgorie_model.dart';
import 'package:news_app/pages/tab_view.dart';
import '../model/source_model.dart';

class CategoryView extends StatefulWidget {
  CategoryModel selected;

  CategoryView({Key? key, required this.selected}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late Future<SourceModel> fetchSource;

  @override
  void initState() {
    fetchSource = ApiManger.fetchSources(widget.selected.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceModel>(
      future: fetchSource,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              Text("${snapshot.error}"),
              IconButton(
                  onPressed: () {
                    fetchSource;
                  },
                  icon: const Icon(Icons.refresh_outlined))
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          SourceModel? source = snapshot.data;
          return TabBarListView((source!) as SourceModel?);
          // ListView.builder(
          //   itemBuilder: (context, index) => TabBarListView(source!),
          //   itemCount: source?.sources?.length ?? 0,
          // );
        }
      },
    );
  }
}
