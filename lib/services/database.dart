import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUserName(String userName) async{
    return await Firestore.instance.collection('users').where("name", isEqualTo: userName).getDocuments();

  }

  uploadUserInfo(userMap){
    Firestore.instance.collection('users').add(userMap);
  }

}