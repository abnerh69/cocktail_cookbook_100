import 'package:cocktail_cookbook/pages/home_page.dart';
import 'package:cocktail_cookbook/utils/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';

import 'package:cocktail_cookbook/dim.dart';

class WCocktailName extends StatefulWidget {
  const WCocktailName({Key? key}) : super(key: key);
  static const widgetName = 'WCocktailName';

  @override
  State<WCocktailName> createState() => _WCocktailNameState();
}

class _WCocktailNameState extends State<WCocktailName> {
  refresh() => setState(() {});

  @override
  void initState() {
    addRefreshWidget(WCocktailName.widgetName, refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!DIM.theCocktailCookbookData.lRandomDrink) {
      return Container();
    }
    return InkWell(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.yellow,
          key: ValueKey<int>(
              DIM.theCocktailCookbookData.randomDrink!.idDrink.toInt() ?? 0),
          child: Stack(
            // padding: EdgeInsets.only(
            //     bottom: MediaQuery.of(context).size.height / 5 +
            //         16.0,
            //     left: 16.0,
            //     right: (MediaQuery.of(context).size.width / 3) -
            //         16.0),
            children: [
              Positioned(
                left: 16.0,
                bottom: MediaQuery.of(context).size.height / 5 +
                      16.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                  color: Colors.black12,
                  height: 150,
                  width: 300,
                  // margin: EdgeInsets.only(
                  //     top: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 5 * 2 ,
                  //     ),
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AnimatedOpacity(
                          opacity: DIM.displayText ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 2000),
                          child: Text(
                              DIM.theCocktailCookbookData.randomDrink!.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 34.0))),
                      AnimatedOpacity(
                          opacity: DIM.displayText ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                  '${DIM.theCocktailCookbookData.randomDrink!.category}\n'
                                  '${DIM.theCocktailCookbookData.randomDrink!.alcoholic}\n'
                                  '${DIM.theCocktailCookbookData.randomDrink!.glass}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      const TextStyle(color: Colors.white70))))
                    ],
                  ),
                ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        debugPrint('Tapped WCocktailName');
        if (!DIM.displayText) {
          DIM.displayText = true;
          DIM.selectedIngredients = false;
          DIM.selectedInstructions = false;
          DIM.selectedInfo = false;
          refreshWidget(HomePage.widgetName);
        }
      },
    );
  }
}
