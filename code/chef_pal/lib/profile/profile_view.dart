// written by: Azim, Malak, Shahir
// tested by: Daniel
// debugged by: Shahir
// Profile View page

import 'package:chef_pal/auth/firebase_auth.dart';
import 'package:chef_pal/grocery_search/models/place.dart';
import 'package:chef_pal/grocery_search/screens/search.dart';
import 'package:chef_pal/grocery_search/services/geolocator_service.dart';
import 'package:chef_pal/grocery_search/services/places_service.dart';
import 'package:chef_pal/ingredient_selection/firestore.dart';
import 'package:chef_pal/ingredient_selection/ingredient_view.dart';
import 'package:chef_pal/profile/intolerences_widget.dart';
import 'package:chef_pal/profile/update_profile_widget.dart';
import 'package:chef_pal/profile/user_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserData>(context, listen: true);
    return Container(
      alignment: Alignment.center,
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
                bottom: MediaQuery.of(context).size.height / 20,
              ),
              child: Text(
                userdata != null ? "Hello ${userdata.userName}" : "Hello",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: MaterialButton(
                color: Colors.orange.shade700,
                onPressed: () {
                  if (userdata != null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ProfileUpdater(
                          userdata: userdata,
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (userdata != null) IntolerencesWidget(),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                color: Colors.orange.shade700,
                onPressed: () async {
                  // PermissionStatus permission =
                  //     await LocationPermissions().requestPermissions();
                  final locatorService = GeoLocatorService();
                  final placesService = PlacesService();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(providers: [
                        FutureProvider(
                          create: (context) => locatorService.getLocation(),
                          initialData: null,
                        ),
                        ProxyProvider<Position, Future<List<Place>>>(
                          update: (context, position, places) {
                            return (position != null)
                                ? placesService.getPlaces(
                                    position.latitude, position.longitude)
                                : null;
                          },
                        )
                      ], child: Search()),
                    ),
                  );
                },
                child: Text(
                  "Search Grocery Stores",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                color: Colors.orange.shade700,
                onPressed: () {
                  context.read<AuthentificationService>().signOut();
                },
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ProfileUpdateDropDown extends StatelessWidget {
//   final String category;
//   const ProfileUpdateDropDown({Key key, this.category}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final expanded = Provider.of<ExpandedDropDown>(context, listen: false);
//     final userdata = Provider.of<UserData>(context);

//     List<Widget> dropdownWidgets = [
//       Container(
//         child: GestureDetector(
//           onTap: () {
//             expanded.flip();
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 category,
//                 style: TextStyle(
//                   fontSize: MediaQuery.of(context).size.width / 25,
//                 ),
//               ),
//               Consumer<ExpandedDropDown>(
//                 builder: (_, expanded, __) => expanded.expanded
//                     ? Icon(Icons.arrow_drop_up)
//                     : Icon(Icons.arrow_drop_down),
//               )
//             ],
//           ),
//         ),
//         decoration: const BoxDecoration(
//           border: Border(
//             bottom: BorderSide(width: 1.0, color: Colors.grey),
//           ),
//         ),
//       ),
//     ];
//     // userdata[category].keys.forEach((ingredient) {
//     //   dropdownWidgets.add(
//     //     ProfileDropDownItem(
//     //       category: category,
//     //       ingredient: ingredient,
//     //     ),
//     //   );
//     // });

//     // return Consumer<ExpandedDropDown>(
//     //   builder: (_, expanded, __) => Container(
//     //     width: MediaQuery.of(context).size.width / 1.4,
//     //     height: expanded.expanded
//     //         ? MediaQuery.of(context).size.height /
//     //             30 *
//     //             (ingredients[category].keys.length + 1)
//     //         : MediaQuery.of(context).size.height / 30,
//     //     child: Column(children: dropdownWidgets),
//     //   ),
//     // );
//   }
// }

class ProfileDropDownItem extends StatelessWidget {
  final String ingredient, category;

  const ProfileDropDownItem(
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
