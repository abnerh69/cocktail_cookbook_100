import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktail_cookbook/dim.dart';

import 'package:cocktail_cookbook/utils/refresh_widget.dart';
import 'package:flutter/material.dart';

class WCocktailImage extends StatefulWidget {
  const WCocktailImage({Key? key}) : super(key: key);
  static const widgetName = 'WCocktailImage';

  @override
  State<WCocktailImage> createState() => _WCocktailImageState();
}

class _WCocktailImageState extends State<WCocktailImage> {
  refresh() => setState(() {});

  @override
  void initState() {
    addRefreshWidget(WCocktailImage.widgetName, refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!DIM.theCocktailCookbookData.lRandomDrink) {
      return Container();
    }
    return CachedNetworkImage(
      imageUrl: DIM.theCocktailCookbookData.randomDrink!.drinkThumb,
      placeholder: (context, url) => Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
    // return Image.network(DIM.theCocktailCookbookData.randomDrink!.drinkThumb);
  }
}
