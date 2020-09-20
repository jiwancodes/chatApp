import 'package:chatApp/helper/constants.dart';
import 'package:chatApp/services/database.dart';
import 'package:chatApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageTextEditingController =
      new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatMessageStream;

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return MessageTile(
                  snapshot.data.documents[index].data["message"],
                  snapshot.data.documents[index].data["sendby"] ==
                      Constants.myName);
            });
      },
    );
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      print("message button working");
      Map<String, dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sendby": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      messageTextEditingController.text = "";
      databaseMethods.sendConversationMessages(widget.chatRoomId, messageMap);
    }
  }

  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          child: Stack(children: [
        chatMessageList(),
        Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: Color(0x54FFFFFF),
            child: Row(children: [
              Expanded(
                  child: TextField(
                controller: messageTextEditingController,
                style: inputTextStyle(),
                decoration: InputDecoration(
                  hintText: "message...",
                  hintStyle: TextStyle(
                    color: Colors.white54,
                  ),
                  border: InputBorder.none,
                ),
              )),
              GestureDetector(
                onTap: () {
                  sendMessage();
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
                        "assets/images/send.png",
                        height: 30,
                        width: 30,
                      ),
                    )),
              ),
            ]),
          ),
        ),
      ])),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  MessageTile(this.message, this.isSentByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSentByMe ? 60 : 24, right: isSentByMe ? 24 : 60),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSentByMe
                  ? [
                      const Color(0xff007EF4),
                      const Color(0xff2A75BC),
                    ]
                  : [
                      const Color(0x1AFFFFFF),
                      const Color(0x1AFFFFFF),
                    ],
            ),
            borderRadius: isSentByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  )),
        child: Text(
          message,
          style: mediumInputTextStyle(),
        ),
      ),
    );
  }
}
