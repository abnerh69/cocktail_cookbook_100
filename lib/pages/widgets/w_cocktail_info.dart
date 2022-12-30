import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dim.dart';
import '../../viewmodels/recipe_viewmodel.dart';
import 'list_card.dart';

class WCocktailInfo extends StatefulWidget {
  const WCocktailInfo({Key? key}) : super(key: key);

  @override
  State<WCocktailInfo> createState() => _WCocktailInfoState();
}

class _WCocktailInfoState extends State<WCocktailInfo> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height / 4,
        left: (MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width / 1.5)) /
            2,
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: DIM.selectedInfo
                ? infoCard(context, 'Info')
                : const SizedBox(height: 0, width: 0)));
  }

  Widget infoCard(BuildContext context, String title) {
    debugPrint('Showing WCocktailInfo');
    return frostedEdged(Container(
        key: ValueKey<String>(title),
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width / 1.5,
        color: Colors.white.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Divider(color: Colors.white70)),
              Expanded(
                  child: ListView(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Center(
                        child: Text(
                            "Ready in ${RecipeViewModel.selected.readyInMinutes} mins"))),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Center(
                        child: Text(
                            "Serves ${RecipeViewModel.selected.servings}"))),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            "Vegan       ",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(
                            RecipeViewModel.selected.vegan
                                ? Icons.check
                                : Icons.close,
                            size: 14.0,
                          ),
                          const Text(
                            "Vegetarian",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(
                            RecipeViewModel.selected.vegetarian
                                ? Icons.check
                                : Icons.close,
                            size: 14.0,
                          )
                        ])),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            "Diary Free  ",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(
                            RecipeViewModel.selected.dairyFree
                                ? Icons.check
                                : Icons.close,
                            size: 14.0,
                          ),
                          const Text(
                            "  Gluten Free",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(
                            RecipeViewModel.selected.glutenFree
                                ? Icons.check
                                : Icons.close,
                            size: 14.0,
                          )
                        ])),
                Text(RecipeViewModel.selected.description),
              ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: const Icon(Icons.favorite_border),
                    onTap: () {
                      //add to favourites
                    },
                  ),
                  InkWell(
                    child: const Icon(Icons.launch),
                    onTap: () {
                      //launch website here using sourceUrl
                      if (kDebugMode) {
                        print(RecipeViewModel.selected.sourceUrl);
                      }
                    },
                  )
                ],
              )
            ],
          ),
        )));
  }
}
