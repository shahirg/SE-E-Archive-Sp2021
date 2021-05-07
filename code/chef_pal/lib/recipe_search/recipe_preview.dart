// written by: Nirav, Michael
// tested by: Malena
// debugged by: Shahir
// Recipe preview widget

import 'package:chef_pal/ingredient_selection/firestore.dart';
import 'package:chef_pal/recipe_search/recipe_display.dart';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePreview extends StatelessWidget {
  final Recipe recipe;
  const RecipePreview({Key key, @required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // if (recipe.imgLink.length > 0) Image.network(recipe.imgLink),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 16,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.2,
                          width: MediaQuery.of(context).size.height / 1.1,
                          child: RecipeView(recipe),
                        ),
                      );
                    },
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 55,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        "Ready Time: ${recipe.readyInMinutes.toString()} Minutes",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 75,
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              Consumer<List<int>>(
                builder: (_, recipeIds, __) => recipeIds == null
                    ? Icon(
                        Icons.favorite_outline,
                        color: Colors.grey,
                      )
                    : GestureDetector(
                        onTap: () {
                          recipeIds.contains(recipe.id)
                              ? context
                                  .read<FirestoreService>()
                                  .unfavoriteRecipe(recipe)
                              : context
                                  .read<FirestoreService>()
                                  .favoriteRecipe(recipe);
                        },
                        child: recipeIds.contains(recipe.id)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.pink,
                              )
                            : Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                              ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
