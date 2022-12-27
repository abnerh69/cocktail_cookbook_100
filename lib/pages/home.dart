// import 'dart:ui';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cocktail_cookbook/viewmodels/recipe_viewmodel.dart';
//
// import 'package:cocktail_cookbook/dim.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State createState() => HomePageState();
// }
//
// class HomePageState extends State<HomePage> {
//   late bool displayText;
//   late bool selectedIngredients;
//   late bool selectedInstructions;
//   late bool selectedInfo;
//
//   @override
//   void initState() {
//     displayText = true;
//     selectedIngredients = false;
//     selectedInstructions = false;
//     selectedInfo = false;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Material(
//         child: SafeArea(
//           child: Stack(
//             fit: StackFit.expand,
//             children: <Widget>[
//               InkWell(
//                 child: AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 200),
//                     child: Container(
//                       key: ValueKey<int>(RecipeViewModel.selected.id),
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                         colorFilter: ColorFilter.mode(
//                             Colors.black.withOpacity(0.3), BlendMode.dstOut),
//                         image: AssetImage(
//                             'assets/${RecipeViewModel.selected.image}'),
//                         fit: BoxFit.cover,
//                       )),
//                       child: Padding(
//                           padding: EdgeInsets.only(
//                               bottom:
//                                   MediaQuery.of(context).size.height / 5 + 16.0,
//                               left: 16.0,
//                               right: (MediaQuery.of(context).size.width / 3) -
//                                   16.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               AnimatedOpacity(
//                                   opacity: displayText ? 1.0 : 0.0,
//                                   duration: const Duration(milliseconds: 200),
//                                   child: Text(RecipeViewModel.selected.title,
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(fontSize: 34.0))),
//                               AnimatedOpacity(
//                                   opacity: displayText ? 1.0 : 0.0,
//                                   duration: const Duration(milliseconds: 200),
//                                   child: Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Text(
//                                           '${DIM.theCocktailCookbookData.randomDrink!.name}',
//                                           maxLines: 3,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                               color: Colors.white70))))
//                             ],
//                           )),
//                     )),
//                 onTap: () {
//                   if (!displayText) {
//                     setState(() {
//                       displayText = true;
//                       selectedIngredients = false;
//                       selectedInstructions = false;
//                       selectedInfo = false;
//                     });
//                   }
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: <Widget>[
//                     TextButton(
//                         onPressed: () {
//                           // DIM.getTheSamples.getTheFilters();
//                           // for (var element in DIM.getTheSamples.categories) {
//                           //   debugPrint(element.name);
//                           // }
//                           // DIM.theCocktailCookbookData.temporalUtil();
//                           DIM.theCocktailCookbookData.initAPIEndpoints();
//                           DIM.theCocktailCookbookData.lookupARandomCocktail();
//                         },
//                         child: const Text('Test The Cocktail Cookbook Data')),
//                     frostedRound(TextField(
//                         cursorColor: Colors.white,
//                         decoration: InputDecoration(
//                             fillColor: Colors.white.withOpacity(0.3),
//                             border: InputBorder.none,
//                             hintText: "Search",
//                             filled: true,
//                             contentPadding: const EdgeInsets.only(top: 14.0),
//                             prefixIcon: const Icon(Icons.search)))),
//                     const Spacer(),
//                     Padding(
//                         padding: const EdgeInsets.only(bottom: 16.0),
//                         child: frostedIconButton(IconButton(
//                           icon: Icon(Icons.restaurant_menu,
//                               color: selectedIngredients
//                                   ? Colors.white
//                                   : Colors.white70),
//                           onPressed: () {
//                             setState(() {
//                               if (displayText) {
//                                 displayText = false;
//                               }
//                               if (selectedIngredients) {
//                                 displayText = true;
//                                 selectedIngredients = false;
//                               } else {
//                                 selectedIngredients = true;
//                                 selectedInstructions = false;
//                                 selectedInfo = false;
//                               }
//                             });
//                           },
//                         ))),
//                     frostedIconButton(IconButton(
//                       icon: Icon(Icons.list,
//                           color: selectedInstructions
//                               ? Colors.white
//                               : Colors.white70),
//                       onPressed: () {
//                         setState(() {
//                           if (displayText) {
//                             displayText = false;
//                           }
//                           if (selectedInstructions) {
//                             displayText = true;
//                             selectedInstructions = false;
//                           } else {
//                             selectedIngredients = false;
//                             selectedInstructions = true;
//                             selectedInfo = false;
//                           }
//                         });
//                       },
//                     )),
//                     Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: frostedIconButton(IconButton(
//                           icon: Icon(Icons.info_outline,
//                               color:
//                                   selectedInfo ? Colors.white : Colors.white70),
//                           onPressed: () {
//                             setState(() {
//                               if (displayText) {
//                                 displayText = false;
//                               }
//                               if (selectedInfo) {
//                                 displayText = true;
//                                 selectedInfo = false;
//                               } else {
//                                 selectedIngredients = false;
//                                 selectedInstructions = false;
//                                 selectedInfo = true;
//                               }
//                             });
//                           },
//                         ))),
//                     const Spacer(),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 4.5,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: RecipeViewModel.recipes.length,
//                         itemBuilder: (context, index) {
//                           return recipeCard(context, index);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 200),
//                   child: selectedIngredients
//                       ? listCard(context, 'Ingredients',
//                           RecipeViewModel.selected.ingredients)
//                       : const SizedBox(height: 0, width: 0)),
//               AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 200),
//                   child: selectedInstructions
//                       ? listCard(context, 'Instructions',
//                           RecipeViewModel.selected.instructions)
//                       : const SizedBox(height: 0, width: 0)),
//               AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 200),
//                   child: selectedInfo
//                       ? infoCard(context, 'Info')
//                       : const SizedBox(height: 0, width: 0)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget frostedRound(Widget child) {
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(50.0),
//         child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: child));
//   }
//
//   Widget frostedIconButton(Widget child) {
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(50.0),
//         child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: Container(
//                 width: 40.0,
//                 height: 40.0,
//                 decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     shape: BoxShape.circle),
//                 child: child)));
//   }
//
//   Widget frostedEdged(Widget child) {
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(15.0),
//         child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: child));
//   }
//
//   Widget listCard(BuildContext context, String title, List<String> list) {
//     return frostedEdged(Container(
//         key: ValueKey<String>(title),
//         height: MediaQuery.of(context).size.height / 2,
//         width: MediaQuery.of(context).size.width / 1.5,
//         color: Colors.white.withOpacity(0.3),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                   padding: const EdgeInsets.only(
//                       left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                         fontSize: 16.0, fontWeight: FontWeight.bold),
//                   )),
//               const Padding(
//                   padding: EdgeInsets.only(left: 16.0, right: 16.0),
//                   child: Divider(color: Colors.white70)),
//               Expanded(
//                   child: ListView.builder(
//                 itemCount: list.length,
//                 itemBuilder: (context, int index) {
//                   return Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(list[index]));
//                 },
//               ))
//             ])));
//   }
//
//   Widget infoCard(BuildContext context, String title) {
//     return frostedEdged(Container(
//         key: ValueKey<String>(title),
//         height: MediaQuery.of(context).size.height / 2,
//         width: MediaQuery.of(context).size.width / 1.5,
//         color: Colors.white.withOpacity(0.3),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 title,
//                 style: const TextStyle(
//                     fontSize: 16.0, fontWeight: FontWeight.bold),
//               ),
//               const Padding(
//                   padding: EdgeInsets.only(top: 8.0),
//                   child: Divider(color: Colors.white70)),
//               Expanded(
//                   child: ListView(children: <Widget>[
//                 Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Center(
//                         child: Text(
//                             "Ready in ${RecipeViewModel.selected.readyInMinutes} mins"))),
//                 Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Center(
//                         child: Text(
//                             "Serves ${RecipeViewModel.selected.servings}"))),
//                 Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           const Text(
//                             "Vegan       ",
//                             style: TextStyle(
//                               fontSize: 14.0,
//                             ),
//                           ),
//                           Icon(
//                             RecipeViewModel.selected.vegan
//                                 ? Icons.check
//                                 : Icons.close,
//                             size: 14.0,
//                           ),
//                           const Text(
//                             "Vegetarian",
//                             style: TextStyle(
//                               fontSize: 14.0,
//                             ),
//                           ),
//                           Icon(
//                             RecipeViewModel.selected.vegetarian
//                                 ? Icons.check
//                                 : Icons.close,
//                             size: 14.0,
//                           )
//                         ])),
//                 Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           const Text(
//                             "Diary Free  ",
//                             style: TextStyle(
//                               fontSize: 14.0,
//                             ),
//                           ),
//                           Icon(
//                             RecipeViewModel.selected.dairyFree
//                                 ? Icons.check
//                                 : Icons.close,
//                             size: 14.0,
//                           ),
//                           const Text(
//                             "  Gluten Free",
//                             style: TextStyle(
//                               fontSize: 14.0,
//                             ),
//                           ),
//                           Icon(
//                             RecipeViewModel.selected.glutenFree
//                                 ? Icons.check
//                                 : Icons.close,
//                             size: 14.0,
//                           )
//                         ])),
//                 Text(RecipeViewModel.selected.description),
//               ])),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   InkWell(
//                     child: const Icon(Icons.favorite_border),
//                     onTap: () {
//                       //add to favourites
//                     },
//                   ),
//                   InkWell(
//                     child: const Icon(Icons.launch),
//                     onTap: () {
//                       //launch website here using sourceUrl
//                       if (kDebugMode) {
//                         print(RecipeViewModel.selected.sourceUrl);
//                       }
//                     },
//                   )
//                 ],
//               )
//             ],
//           ),
//         )));
//   }
//
//   Widget recipeCard(BuildContext context, int index) {
//     return InkWell(
//       child: Padding(
//           padding: const EdgeInsets.only(right: 16.0, top: 32.0),
//           child: frostedEdged(Container(
//               width: MediaQuery.of(context).size.width / 1.75,
//               color: Colors.white.withOpacity(0.3),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                   width: MediaQuery.of(context).size.width / 5,
//                                   height: MediaQuery.of(context).size.width / 5,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       image: DecorationImage(
//                                           fit: BoxFit.fill,
//                                           image: AssetImage(
//                                               'assets/${RecipeViewModel.recipes[index].image}')))),
//                             ])),
//                     Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           SizedBox(
//                               width: (MediaQuery.of(context).size.width / 3.5),
//                               child: Text(RecipeViewModel.recipes[index].title,
//                                   softWrap: true,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               const Icon(
//                                 Icons.schedule,
//                                 color: Colors.white70,
//                                 size: 14.0,
//                               ),
//                               Text(
//                                 RecipeViewModel.recipes[index].readyInMinutes
//                                     .toString(),
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                               const Padding(
//                                   padding: EdgeInsets.only(right: 8.0)),
//                               const Icon(
//                                 Icons.restaurant,
//                                 color: Colors.white70,
//                                 size: 14.0,
//                               ),
//                               Text(
//                                   RecipeViewModel.recipes[index].servings
//                                       .toString(),
//                                   style: const TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14.0,
//                                   )),
//                               const Padding(
//                                   padding: EdgeInsets.only(right: 8.0)),
//                               const Icon(
//                                 Icons.thumb_up,
//                                 color: Colors.white70,
//                                 size: 14.0,
//                               ),
//                               Text(
//                                   RecipeViewModel.recipes[index].likes
//                                       .toString(),
//                                   style: const TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14.0,
//                                   )),
//                             ],
//                           )
//                         ])
//                   ])))),
//       onTap: () {
//         setState(() {
//           RecipeViewModel.selected = RecipeViewModel.recipes[index];
//         });
//       },
//     );
//   }
// }
