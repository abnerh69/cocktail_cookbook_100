import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/dim.dart';
import 'package:cocktail_cookbook/utils/refresh_widget.dart';


class WSearchClearButton extends StatefulWidget {
  const WSearchClearButton({Key? key}) : super(key: key);
  static const widgetName = 'WSearchClearButton';

  @override
  State<WSearchClearButton> createState() => _WSearchClearButtonState();
}

class _WSearchClearButtonState extends State<WSearchClearButton> {
  refresh() => setState(() {});

  @override
  void initState() {
    addRefreshWidget(WSearchClearButton.widgetName, refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (DIM.theCocktailCookbookData.searchController.text.isEmpty) {
      return Container();
    }
    return Positioned(
        right: 5,
        top: 3,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: IconButton(
              icon: Icon(Icons.clear,
                  color:
                      DIM.selectedIngredients ? Colors.white : Colors.white70),
              onPressed: () async {
                DIM.theCocktailCookbookData.searchController.text = '';
              },
            )));
  }
}
