import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/source_model.dart';
import 'package:news_app/pages/widgets/articl_list_view.dart';
import 'package:news_app/pages/widgets/tab_item.dart';

class TabBarListView extends StatefulWidget {
  SourceModel? sourceModel;

  TabBarListView(this.sourceModel);

  @override
  State<TabBarListView> createState() => _TabBarListViewState();
}

class _TabBarListViewState extends State<TabBarListView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          DefaultTabController(
              length: widget.sourceModel?.sources?.length ?? 0,
              child: TabBar(
                dividerHeight: 0,
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                indicator: const BoxDecoration(),
                onTap: (index) {
                  setState(() {});
                  selectedIndex = index;
                },
                isScrollable: true,
                tabs: widget.sourceModel?.sources?.map((element) {
                      return TabItem(
                          element,
                          selectedIndex ==
                              widget.sourceModel?.sources!.indexOf(element));
                    }).toList() ??
                    [],
              )),
          ArticlsListView(widget.sourceModel?.sources?[selectedIndex].id ?? ""),
        ],
      ),
    );
  }
}
