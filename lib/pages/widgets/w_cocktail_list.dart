import 'package:cocktail_cookbook/the_data_db_api/_exports.dart';
import 'package:cocktail_cookbook/utils/refresh_widget.dart';
import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/dim.dart';
import 'list_card.dart';

class WCocktailList extends StatefulWidget {
  const WCocktailList({Key? key}) : super(key: key);
  static const widgetName = 'WCocktailList';

  @override
  State<WCocktailList> createState() => _WCocktailListState();
}

class _WCocktailListState extends State<WCocktailList> {
  refresh() {
    // debugPrint('REFRESHING LIST...');
    setState(() {});
  }

  @override
  void initState() {
    addRefreshWidget(WCocktailList.widgetName, refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height / 4.5,
      height: 160,

      child: Column(
        children: [
          SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: DIM.theCocktailCookbookData.drinkItemsList.length,
                itemBuilder: (context, index) {
                  DrinkItem drinkItem =
                      DIM.theCocktailCookbookData.drinkItemsList[index];
                  return GestureDetector(
                      onTap: () {
                        // DIM.theCocktailCookbookData.newRandomDrink(aDrink)
                        if (DIM.theCocktailCookbookData.randomDrink!.idDrink !=
                            drinkItem.idDrink) {
                          DIM.theCocktailCookbookData
                              .lookupFullCocktailDetailsById(drinkItem.idDrink);
                        }
                      },
                      child: Container(
                          // width: 200,
                          height: 150,
                          margin: const EdgeInsets.only(right: 16.0),
                          // color: Colors.white.withOpacity(0.3),
                          child: frostedEdged(
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    //MediaQuery.of(context).size.width / 5,
                                    height: 100,
                                    // MediaQuery.of(context).size.width / 5,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            NetworkImage(drinkItem.drinkThumb),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Text(drinkItem.name,
                                          maxLines: 3,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            ),
                          )));
                  // return recipeCard(context, index);
                },
              )),
          Text(DIM.theCocktailCookbookData.coctailsFilterTitle),
        ],
      ),
    );
  }
}
