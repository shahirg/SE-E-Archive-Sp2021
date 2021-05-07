// written by: Malak, Azim Daniel
// tested by: Daniel
// debugged by: Shahir
// Widget for updating profile

import 'package:chef_pal/ingredient_selection/firestore.dart';
import 'package:chef_pal/profile/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileUpdater extends StatelessWidget {
  final UserData userdata;
  const ProfileUpdater({Key key, this.userdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> diets = [
      'Gluten Free',
      'Ketogenic',
      'Vegetarian',
      'Lacto-Vegetarian',
      'Ovo-Vegetarian',
      'Vegan',
      'Pescetarian',
      'Paleo',
      'Primal',
      'Whole30',
    ];
    List<String> intolerences = [];
    // final userdata = Provider.of<UserData>(context, listen: false);
    userdata.userIntolerences.forEach((key, value) {
      intolerences.add(key);
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 16,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.2,
        width: MediaQuery.of(context).size.height / 1.1,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Diets",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ChangeNotifierProvider<IsSelected>(
                create: (context) => IsSelected(selected: userdata.userDiet),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: diets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              diets[index],
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 55,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Consumer<IsSelected>(
                            builder: (_, selected, __) => selected == null
                                ? Icon(
                                    Icons.radio_button_off,
                                    color: Colors.grey,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (selected.selected == diets[index]) {
                                        selected.select(null);
                                        userdata.diet = null;
                                      } else {
                                        selected.select(diets[index]);
                                        userdata.diet = diets[index];
                                      }
                                    },
                                    child: selected.selected == diets[index]
                                        ? Icon(
                                            Icons.radio_button_on,
                                            color: Colors.orange,
                                          )
                                        : Icon(
                                            Icons.radio_button_off,
                                            color: Colors.grey,
                                          ),
                                  ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              Text(
                "Intolerences",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ChangeNotifierProvider<CheckedOff>(
                create: (context) =>
                    CheckedOff(checked: userdata.userIntolerences),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: intolerences.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              intolerences[index],
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 55,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Consumer<CheckedOff>(
                            builder: (_, checked, __) => checked == null
                                ? Icon(
                                    Icons.check_box_outline_blank_rounded,
                                    color: Colors.grey,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      checked.check(intolerences[index]);
                                    },
                                    child:
                                        checked.checked[intolerences[index]] ==
                                                true
                                            ? Icon(
                                                Icons.check_box_rounded,
                                                color: Colors.orange,
                                              )
                                            : Icon(
                                                Icons
                                                    .check_box_outline_blank_rounded,
                                                color: Colors.grey,
                                              ),
                                  ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  color: Colors.orange.shade700,
                  onPressed: () {
                    FirestoreService(userdata.uid).updateUserData(userdata);
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
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

class IsSelected with ChangeNotifier {
  String selected;
  IsSelected({@required this.selected});
  void select(String string) {
    selected = string;
    notifyListeners();
  }
}

class CheckedOff with ChangeNotifier {
  Map<String, dynamic> checked;
  CheckedOff({@required this.checked});
  void check(String key) {
    checked[key] = !checked[key];
    notifyListeners();
  }
}
