import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:privatus/constants/design_constants.dart';
  final _firestore = Firestore.instance;


class ChatScreen extends StatefulWidget {
  String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

void messageStream() async{
  await for( var snapshot in  _firestore.collection('messages').snapshots()){
    for (var message in snapshot.documents){
      print(message.data);
    }
  }
}


class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  String messageText;
  TextEditingController messageController = TextEditingController();










  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackbar(){
    // print("show snackbar here");
    final snackBar = new prefix0.SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          Icon(Icons.warning,color: Colors.yellow,),
          Text('This is a snackbar'),
        ],
      ),

    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Privatus Messenger'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
              child: Column(
          children: <Widget>[
            		StreamBuilder(
                  stream: _firestore.collection('messages').snapshots(),
                  builder:(context,snapshot){
                   final messages = snapshot.data.documents;
                   List<Text> messageWidgets = [];
                    for (var message in messages){
                      final messageText = message.data['text'];
                      final messageSender = message.data['sender'];
                      final messageWidget  =  Text('$messageText');
                      messageWidgets.add(messageWidget);
                    }
                   return  Column(
                       children: messageWidgets,
                     
                   );
                  },
                ),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: kMessageTextFieldDecoration,
                      controller: messageController,
                      // onChanged: (value){
                      //   messageText = value;
                      //   print(messageText);
                      // },
                    ),
                  ),
                  FlatButton(
                    color: Colors.blueAccent,
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,),
                      onPressed: (){
                        if(messageController.text!=''){
                          try {
                            _firestore.collection('messages').add({ 
                                'sender': 'ialexies@gmail.com',
                                'text':messageController.text,});
                            print(messageController.text);
                            messageController.clear();
                          } catch (e) { print (e);}
                        }
                        else{ _showSnackbar();}
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}