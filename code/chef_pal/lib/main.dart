// written by: Shahir
// tested by: Shahir
// debugged by: Shahir
// App initilizer

import 'package:chef_pal/auth/auth_view.dart';
import 'package:chef_pal/auth/firebase_auth.dart';
import 'package:chef_pal/home_view.dart';
import 'package:chef_pal/ingredient_selection/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthentificationService>(
          create: (_) => AuthentificationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthentificationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Chefpal',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthentificationWrapper(),
      ),
    );
    //home: Home();
  }
}

class AuthentificationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      // return MultiProvider(
      //   providers: [
      //     Provider<FirestoreService>(
      //       create: (_) => FirestoreService(firebaseUser.uid),
      //     ),
      //     StreamProvider.value(
      //         value: context.read<FirestoreService>().ingredients,
      //         initialData: null)
      //   ],
      //   child: HomeView(),
      // );
      return Provider<FirestoreService>(
        create: (_) => FirestoreService(firebaseUser.uid),
        child: HomeView(),
        // MultiProvider(
        //   providers: [
        //     StreamProvider.value(
        //       value:  FirestoreService(firebaseUser.uid).ingredients,
        //       initialData: null,
        //     ),
        //   ],
        //   child: HomeView(),
        // ),
        // StreamProvider<Map<String, dynamic>>.value(
        //   value: FirestoreService(firebaseUser.uid).ingredients,
        //   initialData: null,
        //   child: HomeView(),
        // ),
      );
    }
    return AuthentificationView();
  }
}
