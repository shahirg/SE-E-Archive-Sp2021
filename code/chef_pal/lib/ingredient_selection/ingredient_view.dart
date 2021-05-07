// written by: Daniel, Nirav, Azim
// tested by:  Azim
// debugged by: Shahir
// Ingredient Selection View for app

import 'package:chef_pal/ingredient_selection/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientsView extends StatefulWidget {
  IngredientsView({Key key}) : super(key: key);

  @override
  _IngredientsViewState createState() => _IngredientsViewState();
}

class _IngredientsViewState extends State<IngredientsView> {
  @override
  Widget build(BuildContext context) {
    final ingredients = Provider.of<Map<String, dynamic>>(context);
    List<Widget> categories = [];
    if (ingredients != null)
      ingredients.keys.forEach((category) {
        categories.add(
          ChangeNotifierProvider<ExpandedDropDown>(
            create: (context) => ExpandedDropDown(),
            child: IngredientDropDown(
              category: category,
            ),
          ),
        );
      });
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 12),
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
                  bottom: MediaQuery.of(context).size.height / 25,
                ),
                child: Text(
                  "Ingredient Selection",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 15,
                  ),
                ),
              ),
              Column(
                children: categories,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientDropDown extends StatelessWidget {
  final String category;
  const IngredientDropDown({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expanded = Provider.of<ExpandedDropDown>(context, listen: false);
    final ingredients = Provider.of<Map<String, dynamic>>(context);

    List<Widget> dropdownWidgets = [
      Container(
        child: GestureDetector(
          onTap: () {
            expanded.flip();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 25,
                ),
              ),
              Consumer<ExpandedDropDown>(
                builder: (_, expanded, __) => expanded.expanded
                    ? Icon(Icons.arrow_drop_up)
                    : Icon(Icons.arrow_drop_down),
              )
            ],
          ),
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
      ),
    ];
    ingredients[category].keys.forEach((ingredient) {
      dropdownWidgets.add(
        IngredientDropDownItem(
          category: category,
          ingredient: ingredient,
        ),
      );
    });

    return Consumer<ExpandedDropDown>(
      builder: (_, expanded, __) => SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          // height: expanded.expanded
          //     ? MediaQuery.of(context).size.height /
          //         30 *
          //         (ingredients[category].keys.length + 1)
          //     : MediaQuery.of(context).size.height / 30,
          child: Column(children: dropdownWidgets),
        ),
      ),
    );
  }
}

class IngredientDropDownItem extends StatelessWidget {
  final String ingredient, category;

  const IngredientDropDownItem(
      {Key key, @required this.category, @required this.ingredient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ingredients = Provider.of<Map<String, dynamic>>(context);

    return Consumer<ExpandedDropDown>(
      builder: (_, expanded, __) => expanded.expanded
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: MediaQuery.of(context).size.height / 30,
                width: MediaQuery.of(context).size.width / 1.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ingredient,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ingredients[category][ingredient] =
                            !ingredients[category][ingredient];
                        print(ingredients);

                        context
                            .read<FirestoreService>()
                            .updateIngredients(ingredients);
                      },
                      child: ingredients[category][ingredient]
                          ? Icon(Icons.remove)
                          : Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}

class ExpandedDropDown with ChangeNotifier {
  bool expanded = false;

  void flip() {
    expanded = !expanded;
    notifyListeners();
  }
}
// class DropIcon extends StatelessWidget {
//   const DropIcon({Key key, this.expanded}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

// class IngredientView extends StatefulWidget {
//   IngredientView({Key key}) : super(key: key);

//   @override
//   _IngredientViewState createState() => _IngredientViewState();
// }

// class _IngredientViewState extends State<IngredientView> {
//   List<Recipe> _recipes = [];
//   List<String> _ingredients = ["cheese", "chicken", "mushrooms"];
//   Map<String, List<String>> ingredientsMap = {
//     "Dairy": ["Milk", "Egg", "Cheese"],
//     "Meats": ["Chicken", "Beef"],
//     "Spices": [],
//     "Seafood": [],
//     "Fruit": [],
//     "Vegetables": [],
//   };
//   void _searchRecipe() async {
//     List<Recipe> _recipesTemp =
//         await ApiService.instance.generateRecipes(_ingredients);
//     setState(() {
//       _recipes = _recipesTemp;
//       print('getting recipes');
//     });
//     // print(_recipes);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 48.0, left: 32.0, right: 32.0),
//         child: Column(
//           children: [
//             Text("Ingredient Page"),
//             CustomDropdown(
//               text: "Dairy",
//               ingredients: ingredientsMap["Dairy"],
//             ),
//             CustomDropdown(
//               text: "Meats",
//               ingredients: ingredientsMap["Meats"],
//             ),
//             CustomDropdown(
//               text: "Spices",
//               ingredients: ingredientsMap["Spices"],
//             ),
//             CustomDropdown(
//               text: "Seafood",
//               ingredients: ingredientsMap["Seafood"],
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width / 1.4,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                 color: Colors.orange.shade400,
//                 onPressed: () async {
//                   _searchRecipe();
//                 },
//                 child: Text(
//                   "Search",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 child: ListView.builder(
//                   itemCount: _recipes.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container(
//                       height: 50,
//                       //color: Colors.amber[colorCodes[index]],
//                       child: MaterialButton(
//                         //color: Colors.orange.shade50,
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return Dialog(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 elevation: 16,
//                                 child: Container(
//                                   height:
//                                       MediaQuery.of(context).size.height / 1.2,
//                                   width:
//                                       MediaQuery.of(context).size.height / 1.1,
//                                   child: RecipeView(_recipes[index]),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         child: Text(
//                           '${_recipes[index].title}',
//                           style: TextStyle(
//                             color: Colors.grey.shade900,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//         //Text("My Ingredients"),
//         //Column(),
//       ),
//     );
//   }
// }
