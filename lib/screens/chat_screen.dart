import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:privatus/constants/design_constants.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

final _currentUser = _auth.currentUser();
FirebaseUser LoggedInUser;
final LoggedInUserEmail = LoggedInUser.email;
ScrollController _scrollController = new ScrollController();

class ChatScreen extends StatefulWidget {
  String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

// void messageStream() async{
//   await for( var snapshot in  _firestore.collection('messages').snapshots()){
//     for (var message in snapshot.documents){
//       print(message.data);
//     }
//   }
// }


class _ChatScreenState extends State<ChatScreen> {
 
  String messageText;
  TextEditingController messageController = TextEditingController();
  

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()async{
    try {
      final user = await  _auth.currentUser();
      if(user!=null){
        LoggedInUser= user;
      }
    } catch (e) { print(e);}

  }

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
        title: Text('Privatus Messenger Pool'),
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
            

            		new MessageStream(),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autofocus: true,
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
                                'sender': '$LoggedInUserEmail',
                                'text':messageController.text,
                                'created': DateTime.now(),
                                });
                            print(messageController.text);
                            messageController.clear();
                            _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                          } catch (e) { print (e);}
                        }
                        else{ 
                          
                          _showSnackbar();
                        }
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

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
      
      stream: _firestore.collection('messages').orderBy('created',descending: true).snapshots(),
      builder:(context,snapshot){

        //check if snapshot has content, return immediately if none
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data.documents.reversed;

        List<MessageBalloon> MessageBalloons = [];
        for (var message in messages){
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final messageBalloon  = MessageBalloon(text: messageText ,sender: messageSender, isMe: messageSender == LoggedInUserEmail);
          MessageBalloons.add(messageBalloon);
        }
        return  Expanded(
          child: ListView(
              // reverse: true,
              controller: _scrollController,
              children: MessageBalloons,
          ),
        );
      },
    );
  }
}


class MessageBalloon extends StatelessWidget {
    
  final String text;
  final String sender;
  final bool isMe;

  MessageBalloon({this.text,this.sender,this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end :  CrossAxisAlignment.start,
        children: <Widget>[
          
          // Text('$sender'),
          Material(
            // borderRadius: BorderRadius.circular(30),
            borderRadius: BorderRadius.only(
              topRight: isMe?  Radius.circular(0): Radius.circular(30) ,
              topLeft: isMe? Radius.circular(30): Radius.circular(0),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe? Colors.grey[300] : Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$text', style: TextStyle(color: isMe? Colors.grey[850]:Colors.white70),),
            ),
          ),
          isMe ? Text(''): Text('$sender'),
        ],
      ),
    );
  }

}



  // return 
  // Text('$messageText')


