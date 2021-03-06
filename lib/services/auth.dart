import 'package:chatApp/helper/helperfunctions.dart';
import 'package:chatApp/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return User != null ? User(userId:user.uid): null;
  }


  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e) {
      print(e.toString());
    }  
  }


  Future signUpWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
     }catch(e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
   }

   Future signOut() async {
        try{
           HelperFunctions.saveUserLoggedInSharedPreference(false);
            return await _auth.signOut();
           

          }catch(e){
             HelperFunctions.saveUserLoggedInSharedPreference(true);
               print(e.toString());
           }
    }

  
}