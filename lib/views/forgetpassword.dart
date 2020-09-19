import 'package:chatApp/services/auth.dart';
import 'package:chatApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isLoading = false;
  TextEditingController emailTextEditingController =
      new TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  sendMail() {
    setState(() {
      isLoading = true;
    });
    if (formKey.currentState.validate()) {
      authMethods.resetPassword(emailTextEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text("Forgot password? Fill in your recovary email address",
                        style: mediumInputTextStyle()),
                    SizedBox(
                      height: 16,
                    ),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? null
                              : "please provide a valid email";
                        },
                        controller: emailTextEditingController,
                        style: inputTextStyle(),
                        decoration: textFieldInputDecoration("email"),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMail();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC),
                            ]),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          "send recovary email",
                          style: mediumInputTextStyle(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )),
          ),
        ));
  }
}
