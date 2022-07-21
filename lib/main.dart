import 'package:barber/view/completesignupcustomer.dart';
import 'package:barber/view/home.dart';
import 'package:barber/view/login.dart';
import 'package:barber/view/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';

late bool isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogin = false;
  } else {
    isLogin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', ''), // Arabic
        const Locale('en', ''), // English
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "login": ( context) => Login(),
        "signUp": ( context) => SignUp(),
        "homePageCustomer": ( context) => Home(),
      },
      home: isLogin == false ? Login() : Home(),
    );
  }
}
