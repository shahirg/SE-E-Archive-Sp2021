// written by: Nirav, Dan
// tested by: Malena Micheal
// debugged by: Shahir 
// etc.

import 'package:chef_pal/ingredient_selection/ingredient_view.dart';
import 'package:chef_pal/profile/user_model.dart';
import 'package:chef_pal/recipe_search/filtering/filtering_widget.dart';
import 'package:chef_pal/recipe_search/filtering/filters_model.dart';
import 'package:chef_pal/recipe_search/recipe_list_widget.dart';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:chef_pal/recipe_search/spoonacular_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<SearchResult>(
            create: (context) => SearchResult(),
          ),
          ChangeNotifierProvider<RecipeFilters>(
            create: (context) => RecipeFilters(),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SearchBar(),
                ChangeNotifierProvider<ExpandedFilters>(
                  create: (context) => ExpandedFilters(),
                  child: FilteringWidget(),
                ),
                RecipeSearchDisplay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResult with ChangeNotifier {
  List<Recipe> recipes = [];
  void setRecipes(
      String search, RecipeFilters filters, UserData userdata) async {
    recipes =
        await ApiService.instance.searchRecipes(search, filters, userdata);
    notifyListeners();
  }

  void ingredientSearch(Map<String, dynamic> ingredientsMap,
      RecipeFilters filters, UserData userdata) async {
    List<String> ingredients = [];
    ingredientsMap.forEach((category, value) {
      value.forEach((ingredient, status) {
        if (status) ingredients.add(ingredient);
      });
    });
    print(ingredients);

    List<Recipe> unfilteredRecipes =
        await ApiService.instance.generateRecipes(ingredients);
    print(unfilteredRecipes.length);
    List<Recipe> filteredRecipes = [];
    if (userdata.userDiet != null) {
      for (Recipe recipe in unfilteredRecipes) {
        if (recipe.diets.contains(userdata.userDiet.toLowerCase())) {
          filteredRecipes.add(recipe);
        }
      }
    }
    recipes = filteredRecipes;
    print(recipes.length);
    notifyListeners();
  }
}

class RecipeSearchDisplay extends StatelessWidget {
  const RecipeSearchDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchResult>(
      builder: (_, recipes, __) => RecipeListWidget(
        recipes: recipes.recipes,
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchField = TextEditingController();
    final recipes = Provider.of<SearchResult>(context, listen: false);
    final userdata = Provider.of<UserData>(context, listen: false);
    final ingredients =
        Provider.of<Map<String, dynamic>>(context, listen: false);
    final filters = Provider.of<RecipeFilters>(context, listen: false);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextFormField(
            style: TextStyle(color: Colors.grey.shade700),
            controller: _searchField,
            decoration: InputDecoration(
              labelText: "Search all Recipes",
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: MaterialButton(
            color: Colors.orange.shade700,
            onPressed: () async {
              recipes.setRecipes(_searchField.text, filters, userdata);
            },
            child: Text(
              "Search",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: MaterialButton(
            color: Colors.orange.shade700,
            onPressed: () async {
              // print(ingredients);
              recipes.ingredientSearch(ingredients, filters, userdata);
            },
            child: Text(
              "Ingredient Based Search",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ExpandedFilters with ChangeNotifier {
  bool expanded = false;

  void flip() {
    expanded = !expanded;
    notifyListeners();
  }
}
