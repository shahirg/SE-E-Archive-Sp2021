// written by: Micheal
// tested by: Nirav
// debugged by: 
// Creates list of recipes

import 'package:chef_pal/recipe_search/recipe_preview.dart';
import 'package:flutter/material.dart';

class RecipeListWidget extends StatelessWidget {
  final recipes;
  const RecipeListWidget({Key key, @required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 40),
        child: SizedBox(
          child: ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              return RecipePreview(recipe: recipes[index]);
            },
          ),
        ),
      ),
    );
  }
}
