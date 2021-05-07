// written by: Shahir
// tested by:
// debugged by:
// Main app page when logged in

import 'package:chef_pal/ingredient_selection/firestore.dart';
import 'package:chef_pal/ingredient_selection/ingredient_view.dart';
import 'package:chef_pal/profile/profile_view.dart';
import 'package:chef_pal/recipe_search/search_view.dart';
import 'package:chef_pal/saved_recipes/saved_recipes_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    IngredientsView(),
    SearchView(),
    SavedRecipesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }
    // create streams for data to be pass down the widget tree
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: context.read<FirestoreService>().ingredients,
          initialData: null,
        ),
        StreamProvider.value(
          value: context.read<FirestoreService>().savedRecipes,
          initialData: null,
        ),
        StreamProvider.value(
          value: context.read<FirestoreService>().savedRecipeIds,
          initialData: null,
        ),
        StreamProvider.value(
          value: context.read<FirestoreService>().userdata,
          initialData: null,
        ),
      ],
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Saved',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
