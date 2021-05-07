// written by: Shahir, Daniel, Malak
// tested by:  Micheal
// debugged by: Shahir, Malak
// etc.

import 'package:chef_pal/recipe_search/recipe_list_widget.dart';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedRecipesView extends StatelessWidget {
  const SavedRecipesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedRecipes = Provider.of<List<Recipe>>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 4,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 25,
              ),
              child: Text(
                "Saved Recipes",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                ),
              ),
            ),
            if (savedRecipes != null)
              RecipeListWidget(
                recipes: savedRecipes,
              )
          ],
        ),
      ),
    );
  }
}
