import 'package:cocktail_cookbook/pages/home_page.dart';
import 'package:cocktail_cookbook/pages/widgets/w_home_overlaping.dart';
import 'package:cocktail_cookbook/utils/refresh_widget.dart';
import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/dim.dart';

import 'frosted_icon_button.dart';

class WHomeButtons extends StatefulWidget {
  const WHomeButtons({Key? key}) : super(key: key);

  @override
  State<WHomeButtons> createState() => _WHomeButtonsState();
}

class _WHomeButtonsState extends State<WHomeButtons> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        color: Colors.black12,
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: frostedIconButton(IconButton(
                  icon: Icon(Icons.refresh_outlined,
                      color: DIM.selectedIngredients
                          ? Colors.white
                          : Colors.white70),
                  onPressed: () async {
                    await DIM.theCocktailCookbookData.lookupARandomCocktail();
                    // setState(() {
                      DIM.displayText = true;
                      DIM.selectedIngredients = false;
                      DIM.selectedInstructions = false;
                      DIM.selectedInfo = false;
                    // });
                    refreshWidget(WHomeOverlaping.widgetName);
                  },
                ))),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: frostedIconButton(IconButton(
                  icon: Icon(Icons.restaurant_menu,
                      color: DIM.selectedIngredients
                          ? Colors.white
                          : Colors.white70),
                  onPressed: () {
                    debugPrint('Ingredients button pressed');
                    // setState(() {
                      if (DIM.displayText) {
                        DIM.displayText = false;
                      }
                      if (DIM.selectedIngredients) {
                        DIM.displayText = true;
                        DIM.selectedIngredients = false;
                      } else {
                        DIM.selectedIngredients = true;
                        DIM.selectedInstructions = false;
                        DIM.selectedInfo = false;
                      }
                    // });
                    refreshWidget(WHomeOverlaping.widgetName);

                  },
                ))),
            frostedIconButton(IconButton(
              icon: Icon(Icons.list,
                  color:
                      DIM.selectedInstructions ? Colors.white : Colors.white70),
              onPressed: () {
                debugPrint('Instructions button pressed');
                // setState(() {
                  if (DIM.displayText) {
                    DIM.displayText = false;
                  }
                  if (DIM.selectedInstructions) {
                    DIM.displayText = true;
                    DIM.selectedInstructions = false;
                  } else {
                    DIM.selectedIngredients = false;
                    DIM.selectedInstructions = true;
                    DIM.selectedInfo = false;
                  }
                // });
                refreshWidget(WHomeOverlaping.widgetName);

              },
            )),
            // Padding(
            //     padding: const EdgeInsets.only(top: 16.0),
            //     child: frostedIconButton(IconButton(
            //       icon: Icon(Icons.info_outline,
            //           color: DIM.selectedInfo ? Colors.white : Colors.white70),
            //       onPressed: () {
            //         debugPrint('Info button pressed');
            //         // setState(() {
            //           if (DIM.displayText) {
            //             DIM.displayText = false;
            //           }
            //           if (DIM.selectedInfo) {
            //             DIM.displayText = true;
            //             DIM.selectedInfo = false;
            //           } else {
            //             DIM.selectedIngredients = false;
            //             DIM.selectedInstructions = false;
            //             DIM.selectedInfo = true;
            //           }
            //         // });
            //         refreshWidget(WHomeOverlaping.widgetName);
            //
            //       },
            //     ))),
          ],
        ),
      ),
    );
  }
}
