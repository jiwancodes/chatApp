import 'package:chatApp/helper/constants.dart';
import 'package:chatApp/helper/helperfunctions.dart';
import 'package:chatApp/services/auth.dart';
import 'package:chatApp/services/database.dart';
import 'package:chatApp/views/search.dart';
import 'package:chatApp/views/signin.dart';
import 'package:chatApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatroomTile(
                      snapshot.data.documents[index].data["chatroomid"]);
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((val) {
      chatRoomStream = val;
    });
  }

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
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          }),
    );
  }
}

class ChatroomTile extends StatelessWidget {
  final String username;
  ChatroomTile(this.username);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal:24,vertical :8),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Container(
              alignment: AlignmentDirectional.center,
                child: Text(
              "${username.substring(0, 1).toUpperCase()}",
              style: mediumInputTextStyle(),
            )),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            username,
            style: mediumInputTextStyle(),
          ),
        ],
      ),
    );
  }
}
