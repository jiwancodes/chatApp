import 'package:chatApp/widgets/widgets.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:Container(
              child: Container(
          padding: EdgeInsets.symmetric(horizontal:24.0),
          child: Column(
            children: [
              TextField(
                style: inputTextStyle(),
                decoration: textFieldInputDecoration("email"),
              ),
              TextField(
                style: inputTextStyle(),
                decoration: textFieldInputDecoration("password"),
              ),

            ],
            ),
        ),
      ),
    
    );
  }
}