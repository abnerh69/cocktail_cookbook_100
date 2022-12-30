import 'package:cocktail_cookbook/pages/widgets/w_cocktail_info.dart';
import 'package:cocktail_cookbook/pages/widgets/w_cocktail_ingredients.dart';
import 'package:cocktail_cookbook/pages/widgets/w_cocktail_instructions.dart';
import 'package:cocktail_cookbook/pages/widgets/w_search_results.dart';
import 'package:flutter/material.dart';

import '../../utils/refresh_widget.dart';

class WHomeOverlaping extends StatefulWidget {
  const WHomeOverlaping({Key? key}) : super(key: key);
  static const widgetName = 'WHomeOverlaping';

  @override
  State<WHomeOverlaping> createState() => _WHomeOverlapingState();
}

class _WHomeOverlapingState extends State<WHomeOverlaping> {
  refresh() => setState(() {});

  @override
  void initState() {
    addRefreshWidget(WHomeOverlaping.widgetName, refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WCocktailIngredients(key: UniqueKey()),
        WCocktailInstructions(key: UniqueKey()),
        WCocktailInfo(key: UniqueKey()),
      ],
    );
  }
}
