// written by: Aswathy, Azim Amanda
// tested by: Aswathy
// debugged by: Azim
// etc.

import 'package:flutter/material.dart';

class RecipeFilters with ChangeNotifier {
  Map<String, bool> cuisines = {
    'African': false,
    'American': false,
    'British': false,
    'Cajun': false,
    'Caribbean': false,
    'Chinese': false,
    'Eastern European': false,
    'European': false,
    'French': false,
    'German': false,
    'Greek': false,
    'Indian': false,
    'Irish': false,
    'Italian': false,
    'Japanese': false,
    'Jewish': false,
    'Korean': false,
    'Latin American': false,
    'Mediterranean': false,
    'Mexican': false,
    'Middle Eastern': false,
    'Nordic': false,
    'Southern': false,
    'Spanish': false,
    'Thai': false,
    'Vietnamese': false,
  };
  Map<String, bool> mealtypes = {
    'main course': false,
    'side dish': false,
    'dessert': false,
    'appetizer': false,
    'salad': false,
    'bread': false,
    'breakfast': false,
    'soup': false,
    'beverage': false,
    'sauce': false,
    'marinade': false,
    'fingerfood': false,
    'snack': false,
    'drink': false,
  };

  List<String> get cuisinesList {
    List<String> list = [];
    cuisines.forEach((cuisine, value) {
      if (value) {
        list.add(cuisine);
      }
    });
    return list;
  }

  List<String> get mealtypesList {
    List<String> list = [];
    mealtypes.forEach((mealtype, value) {
      if (value) {
        list.add(mealtype);
      }
    });
    return list;
  }

  void selectMealType(String mealtype) {
    mealtypes[mealtype] = !mealtypes[mealtype];
    notifyListeners();
  }

  void selectCuisine(String cuisine) {
    cuisines[cuisine] = !cuisines[cuisine];
    notifyListeners();
  }

  // List<String> mealtypes = [
  //   'main course',
  //   'side dish',
  //   'dessert',
  //   'appetizer',
  //   'salad',
  //   'bread',
  //   'breakfast',
  //   'soup',
  //   'beverage',
  //   'sauce',
  //   'marinade',
  //   'fingerfood',
  //   'snack',
  //   'drink',
  // ];
}
