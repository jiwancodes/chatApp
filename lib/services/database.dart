import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUserName(String userName) async {
    return await Firestore.instance
        .collection('users')
        .where("name", isEqualTo: userName)
        .getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance
        .collection('users')
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection('users').add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomID, chatRoomMap){
   Firestore.instance
        .collection("chatRoom")
        .document(chatRoomID)
        .setData(chatRoomMap)
        .catchError((onError) {
      print(onError.toString());
    });
  }

  sendConversationMessages(String chatRoomId, messageMap) async{
   await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats").orderBy("time",descending: false)
        .snapshots();
  }

  getChatRooms(String userName)async{
    return await Firestore.instance.collection("chatRoom").where("users",arrayContains:userName).snapshots();

  }
}
