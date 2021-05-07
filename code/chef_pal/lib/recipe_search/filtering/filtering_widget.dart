// written by: Azim Shahir Amanda
// tested by: Aswathy
// debugged by: Shahir
// Widget for recipe filters

import 'package:chef_pal/ingredient_selection/ingredient_view.dart';
import 'package:chef_pal/profile/update_profile_widget.dart';
import 'package:chef_pal/recipe_search/filtering/filters_model.dart';
import 'package:chef_pal/recipe_search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilteringWidget extends StatelessWidget {
  const FilteringWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> mealtypes = [
      'main course',
      'side dish',
      'dessert',
      'appetizer',
      'salad',
      'bread',
      'breakfast',
      'soup',
      'beverage',
      'sauce',
      'marinade',
      'fingerfood',
      'snack',
      'drink',
    ];
    List<String> cuisines = [
      'African',
      'American',
      'British',
      'Cajun',
      'Caribbean',
      'Chinese',
      'Eastern European',
      'European',
      'French',
      'German',
      'Greek',
      'Indian' 'Irish',
      'Italian',
      'Japanese',
      'Jewish',
      'Korean',
      'Latin American',
      'Mediterranean' 'Mexican',
      'Middle Eastern',
      'Nordic',
      'Southern',
      'Spanish',
      'Thai',
      'Vietnamese',
    ];

    return Consumer<ExpandedFilters>(
      builder: (_, expanded, __) => Container(
        width: MediaQuery.of(context).size.width / 1.3,
        height: expanded.expanded
            ? MediaQuery.of(context).size.height / 1.5
            : MediaQuery.of(context).size.height / 38,
        child: GestureDetector(
          onTap: () {
            expanded.flip();
            //show filtereing shits
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 55,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 55),
                    child: expanded.expanded
                        ? Icon(Icons.arrow_drop_up)
                        : Icon(Icons.arrow_drop_down),
                  ),

                  //listview for cuisines
                ],
              ),
              //Listview for mealtype
              if (expanded.expanded)
                Text(
                  "Meal Types",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (expanded.expanded)
                Consumer<RecipeFilters>(
                  builder: (_, filters, __) => Expanded(
                    child: SizedBox(
                      height: 200, //MediaQuery.of(context).size.height / 1.5,
                      child: ListView.builder(
                        itemCount: filters.mealtypes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  mealtypes[index],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              65,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  filters.selectMealType(mealtypes[index]);
                                },
                                child: filters.mealtypes[mealtypes[index]] ==
                                        true
                                    ? Icon(
                                        Icons.check_box_rounded,
                                        color: Colors.orange,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank_rounded,
                                        color: Colors.grey,
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              if (expanded.expanded)
                Text(
                  "Cuisines",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (expanded.expanded)
                Consumer<RecipeFilters>(
                  builder: (_, filters, __) => Expanded(
                    child: SizedBox(
                      height: 200, //MediaQuery.of(context).size.height / 1.5,
                      child: ListView.builder(
                        itemCount: filters.mealtypes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  cuisines[index],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              65,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  filters.selectCuisine(cuisines[index]);
                                },
                                child: filters.cuisines[cuisines[index]] == true
                                    ? Icon(
                                        Icons.check_box_rounded,
                                        color: Colors.orange,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank_rounded,
                                        color: Colors.grey,
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
