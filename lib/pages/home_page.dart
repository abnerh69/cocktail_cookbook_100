import 'package:cocktail_cookbook/pages/widgets/w_home_overlaping.dart';
import 'package:cocktail_cookbook/utils/refresh_widget.dart';
import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/dim.dart';
import 'package:cocktail_cookbook/pages/widgets/_exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const widgetName = 'HomePage';

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  refresh() => setState(() {});

  @override
  void initState() {
    loadRandomDrink();
    addRefreshWidget(HomePage.widgetName, refresh);
    super.initState();
  }

  loadRandomDrink() async {
    if (!DIM.theCocktailCookbookData.lRandomDrink) {
      await DIM.theCocktailCookbookData.lookupARandomCocktail();
    }
    if (DIM.theCocktailCookbookData.lRandomDrink) {
      refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('Showing HomePage');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Material(
        child: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              WAppBackground(key: UniqueKey()),
              WCocktailImage(key: UniqueKey()),
              WCocktailName(key: UniqueKey()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const <Widget>[
                    // WTestButton(),
                    WCocktailSearch(),
                    Spacer(),
                    WHomeButtons(),
                    Spacer(),
                    WCocktailList(),
                  ],
                ),
              ),
              const WHomeOverlaping(),
              const WSearchResults(),
              // WCocktailIngredients(key: UniqueKey()),
              // WCocktailInstructions(key: UniqueKey()),
              // WCocktailInfo(key: UniqueKey()),
            ],
          ),
        ),
      ),
    );
  }
}
