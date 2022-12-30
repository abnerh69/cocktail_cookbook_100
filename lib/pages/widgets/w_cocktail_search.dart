import 'dart:ui';

import 'package:cocktail_cookbook/pages/widgets/w_clear_search_button.dart';
import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/dim.dart';

class WCocktailSearch extends StatefulWidget {
  const WCocktailSearch({Key? key}) : super(key: key);

  @override
  State<WCocktailSearch> createState() => _WCocktailSearchState();
}

class _WCocktailSearchState extends State<WCocktailSearch> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return frostedRound(Form(
        key: formKey,
        child: Stack(
          children: [
            TextField(
                cursorColor: Colors.white,
                controller: DIM.theCocktailCookbookData.searchController,
                decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.3),
                    border: InputBorder.none,
                    hintText: "Search",
                    filled: true,
                    contentPadding: const EdgeInsets.only(top: 14.0),
                    // suffix: ,
                    prefixIcon: const Icon(Icons.search))),
            const WSearchClearButton(),
          ],
        )));
  }

  Widget frostedRound(Widget child) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: child));
  }
}
