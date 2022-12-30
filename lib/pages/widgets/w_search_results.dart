import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/dim.dart';
import 'package:cocktail_cookbook/utils/refresh_widget.dart';

class WSearchResults extends StatefulWidget {
  const WSearchResults({Key? key}) : super(key: key);
  static const widgetName = 'WSearchResults';

  @override
  State<WSearchResults> createState() => _WSearchResultsState();
}

class _WSearchResultsState extends State<WSearchResults> {
  refresh() => setState(() {});

  @override
  void initState() {
    addRefreshWidget(WSearchResults.widgetName, refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (DIM.theCocktailCookbookData.searchResult.isEmpty) {
      return Container();
    }
    return Positioned(
      top: 70,
      left: 20,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width * .8,
        color: Colors.black12.withAlpha(150),
        child: ListView(
          children: DIM.theCocktailCookbookData.searchResult.map((e) {
            if (e.type == 'T') {
              return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    e.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ));
            }
            return GestureDetector(
                onTap: () {
                  DIM.theCocktailCookbookData.searchResultSelected(e);
                },
                child: Container(
                    color: Colors.black12,
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      e.name,
                      style: const TextStyle(fontSize: 16),
                    )));
          }).toList(),
        ),
      ),
    );
  }
}
