import 'package:flutter/material.dart';
import 'package:make_paper/helper/functions.dart';
import 'package:make_paper/views/home.dart';
import 'package:make_paper/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedin=false;
  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus()async{
    HelperFunctions.getUserLoggedInDetails().then((value) {
      setState(() {
        _isLoggedin=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:(_isLoggedin?? false) ? Home() : SignIn(),
    );
  }
}