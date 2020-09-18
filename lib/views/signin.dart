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
      body:SingleChildScrollView(
              child: Container(
                height:MediaQuery.of(context).size.height-50,
                alignment: Alignment.bottomCenter, 
                child: Container(
                 padding: EdgeInsets.symmetric(horizontal:24.0),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                children: [
                TextField(
                  style: inputTextStyle(),
                  decoration: textFieldInputDecoration("email"),
                ),
                TextField(
                  style: inputTextStyle(),
                  decoration: textFieldInputDecoration("password"),
                ),
                SizedBox(height: 16,),
                Container(
                   alignment:Alignment.centerRight,
                   child: Container(
                     padding: EdgeInsets.symmetric( vertical:8, horizontal:12),
                     child: Text("forgot password?", style: inputTextStyle(),
                      )
                    ),
                ),
                SizedBox(height: 16,),
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC),
                         ]
                      ),
                      borderRadius:BorderRadius.circular(30.0)
                     ),
                   child:Text("Sign In",style: mediumInputTextStyle(),),
                   ),
                   SizedBox(height: 16,),
                   Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius:BorderRadius.circular(30.0)
                     ),
                   child:Text("Sign In with Google",style:TextStyle(
                     color:Colors.black87,
                     fontSize: 18.0,
                   ),),
                   ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                       children: [
                         Text("don't have an account? ", style: inputTextStyle(),
                          ),
                          Text("Register now ", style:TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                          ),
                          ),
                       ],
                     ),
                      SizedBox(height: 50,),

              ],
              ),
          ),
        ),
      ),
    
    );
  }
}