// written by: Shahir, Malena, Malak, Dymitriy
// tested by: Aswathy 
// debugged by: Shahir, Amanda
// Authentification Page for Registration and Login

import 'package:chef_pal/auth/firebase_auth.dart';
import 'package:chef_pal/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthentificationView extends StatefulWidget {
  @override
  _AuthentificationViewState createState() => _AuthentificationViewState();
}

class _AuthentificationViewState extends State<AuthentificationView> {
  //captures text for textfields
  final TextEditingController _usernameField = TextEditingController();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _passwordCheckField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool login = true;
  bool loading = false;
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white10,
        ),
        child: Stack(
          children: <Widget>[
            if (loading) Loading(size: 4),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 4,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (!login)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                  if (!login)
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextFormField(
                        validator: (_usernameField) =>
                            !(_usernameField.length > 3)
                                ? 'Username Must be at least 3 characters long'
                                : null,
                        style: TextStyle(color: Colors.grey.shade700),
                        controller: _usernameField,
                        decoration: InputDecoration(
                          // hintText: "Username",
                          // hintStyle: TextStyle(color: Colors.grey.shade400),
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: _emailField,
                      validator: (_emailField) =>
                          _emailField.isEmpty ? 'Enter and Email' : null,
                      style: TextStyle(color: Colors.grey.shade700),
                      decoration: InputDecoration(
                        hintText: "something@email.com",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      validator: (_passwordField) => _passwordField.length < 8
                          ? 'Password must be at least 8 characters long'
                          : null,
                      controller: _passwordField,
                      obscureText: true,
                      style: TextStyle(
                          color:
                              Colors.grey.shade700), //blocks characters typed
                      decoration: InputDecoration(
                        hintText: "password",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  if (!login)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                  if (!login)
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextFormField(
                        validator: (_passwordCheckField) =>
                            !(_passwordCheckField == _passwordField.text)
                                ? 'Password do not match'
                                : null,
                        style: TextStyle(color: Colors.grey.shade700),
                        controller: _passwordCheckField,
                        obscureText: true, //blocks characters typed
                        decoration: InputDecoration(
                          hintText: "password",
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      color: Colors.orange.shade700,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          Future<String> _result;
                          if (login) {
                            _result =
                                context.read<AuthentificationService>().signIn(
                                      _emailField.text.trim(),
                                      _passwordField.text.trim(),
                                    );
                          } else {
                            _result =
                                context.read<AuthentificationService>().signUp(
                                      _usernameField.text.trim(),
                                      _emailField.text.trim(),
                                      _passwordField.text.trim(),
                                    );
                          }

                          _result.asStream().forEach((element) {
                            if (element != "Signed In" ||
                                element != "Signed Up") {
                              setState(() {
                                loading = false;
                                error = login
                                    ? "Could not sign in with those credentials"
                                    : "Failed to Register";
                              });
                            }
                          });
                        }
                      },
                      child: Text(
                        login ? "Login" : "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Expanded(
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                login
                                    ? "Need an Account?"
                                    : "Already have an Account?",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() => login = !login);
                                },
                                child: Text(login ? "Sign Up" : "Login"),
                              )
                            ],
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}









// /            Container(
//               width: MediaQuery.of(context).size.width / 1.4,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                 color: Colors.orange.shade400,
//                 onPressed: () async {
//                   await FirebaseFirestore.instance
//                       .collection('data')
//                       .doc('ingredients')
//                       .set({
//                     'ingredients': {
//                       'Meats': [
//                         "Chicken",
//                         "Beef",
//                         "Lamb",
//                         "Pork",
//                       ],
//                       "Dairy": [
//                         "Milk",
//                         "Egg",
//                         "Cheese",
//                         "Yogurt",
//                         "Heavy Cream",
//                         "Swiss Cheese",
//                       ],
//                       "Spices": [],
//                       "Seafood": [],
//                       "Fruit": [],
//                       "Vegetables": [],
//                     }
//                   }).then((value) => print("updated ingredients"));
//                   // await FirebaseFirestore.instance
//                   //     .collection('data')
//                   //     .doc('ingredients')
//                   //     .update({
//                   //   'ingredients': {
//                   //     'Meats': [
//                   //       "Lamb",
//                   //       "Pork",
//                   //     ],
//                   //     "Dairy": [
//                   //       "Yogurt",
//                   //       "Heavy Cream",
//                   //       "Swiss Cheese",
//                   //     ],
//                   //   }
//                   // }).then((value) => print("update values"));
//                 },
//                 child: Text(
//                   "Do Something",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

