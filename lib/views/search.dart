import 'package:chatApp/services/auth.dart';
import 'package:chatApp/services/database.dart';
import 'package:chatApp/views/conversationscreen.dart';
import 'package:chatApp/views/signin.dart';
import 'package:chatApp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatApp/helper/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();
      String searchName;
      
  QuerySnapshot searchSnapshot;

  createChatRoomAndStartConversation( String userName){
    String chatRoomId = getChatRoomId(Constants.myName, userName);
    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomid": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId)));
  }

  initiateSearch() {
    databaseMethods
        .getUserByUserName(searchTextEditingController.text)
        .then((val) {
      print(val.toString());
      setState(() {
        searchSnapshot = val;
       if( searchSnapshot != null){
         searchName=searchTextEditingController.text;

       }
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.documents.length,
            itemBuilder: (context, index) {
              return searchTile(
                userName: searchSnapshot.documents[index].data["name"],
                userEmail: searchSnapshot.documents[index].data["email"],
              );
            })
        : Container();
  }
  Widget searchTile({String userName,String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: mediumInputTextStyle(),
              ),
              Text(
                userEmail,
                style: mediumInputTextStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(searchName);
            },
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "message",
                  style: mediumInputTextStyle(),
                )),
          )
        ],
      ),
    );
  }

  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('FlutterChatApp')),
          actions: [
            GestureDetector(
              onTap: () {
                authMethods.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.exit_to_app)),
            )
          ],
        ),
        body: Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Color(0x54FFFFFF),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: searchTextEditingController,
                  style: inputTextStyle(),
                  decoration: InputDecoration(
                    hintText: "Search Username...",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                    border: InputBorder.none,
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                      padding: EdgeInsets.all(8),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0x36FFFFFF),
                          const Color(0x0FFFFFFF)
                        ]),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Image.asset(
                          "assets/images/search_white.png",
                          height: 30,
                          width: 30,
                        ),
                      )),
                ),
              ]),
            ),
            searchList(),
          ]),
        ));
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
