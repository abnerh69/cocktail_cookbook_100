import 'package:flutter/material.dart';
import 'package:cocktail_cookbook/pages/home_page.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.white,
          // accentColor: Colors.white,
          dialogBackgroundColor: Colors.transparent),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
