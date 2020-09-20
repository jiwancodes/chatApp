import 'package:chatApp/helper/helperfunctions.dart';
import 'package:chatApp/views/chatroomscreen.dart';
import 'package:chatApp/views/signin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;
  @override
  void initState(){
     getLoggedInState();
    super.initState();
  }
  getLoggedInState()async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((val){
      setState(() {
        userIsLoggedIn = val;
      });
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:userIsLoggedIn && userIsLoggedIn!=null?ChatRoom() : SignIn(),
    );
  }
}

