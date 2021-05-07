// written by: Azim, Malak, Daniel
// tested by: Shahir
// debugged by: Shahir
// Intolerences View

import 'package:chef_pal/profile/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntolerencesWidget extends StatelessWidget {
  const IntolerencesWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserData>(context, listen: true);
    String intol = "";
    userdata.intolerences.forEach((intolerence, value) {
      if (value == true) {
        intol += "${intolerence}, ";
      }
    });
    return Container(
      height: MediaQuery.of(context).size.height / 8.5,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // if (recipe.imgLink.length > 0) Image.network(recipe.imgLink),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "Intolerences",
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
                      "${intol.length > 0 ? intol.substring(0, intol.length - 2) : "None"}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 75,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "Diet",
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
                      userdata.userDiet == null ? "None" : userdata.userDiet,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 75,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
