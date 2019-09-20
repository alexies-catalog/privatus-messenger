import 'package:flutter/material.dart';
// import 'package:privatus/components/txtfield_rounded.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:privatus/constants/design_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privatus/screens/chat_screen.dart';
import 'package:async/async.dart';


class RegistrationScreen extends StatefulWidget {
   String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                     
                      SizedBox(height: 30,),
                      Text('registration'),
                      Image(
                        image: AssetImage('images/logo_150.png'),
                        width: 80,
                      ),
                
                      SizedBox(height: 50,),
                      ColorizeAnimatedTextKit(
                        onTap: () {
                            print("Tap Event");
                          },
                        text: [
                          "Create an Account",
                        ],
                        textStyle: TextStyle(
                            fontSize: 30.0, 
                            fontFamily: "Horizon",
                            fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Colors.blue[50],
                          Colors.blue[300],
                      
                        ],
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                      ),

                      // SizedBox(height: 10,),
                      //(hinttext,passchar,keyboardtype)
                      Container(width: 200, child: Column(
                        children: <Widget>[
                          // RoundedTxtField('Insert Email Address',false,  ),
                          // RoundedTxtField(txttitle: 'login', passChar:false, txtonChanged: (){}),
                          // RoundedTxtField('email', false, (value){email = value}),
                          SizedBox(height: 15,),
                          // RoundedTxtField('Insert Password',true,),

                          TextField(
                            textAlign: TextAlign.center,
                            // obscureText: passChar,
                            keyboardType:TextInputType.emailAddress,
                            decoration: GenTxtInputField.copyWith(hintText: 'Insert Email'),
                            style: TextStyle(fontSize: 17),
                            onChanged: (value){
                              email = value;
                            },  
                          ),
                          SizedBox(height: 15,),
                          TextField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                     
                            keyboardType:TextInputType.emailAddress,
                            decoration: GenTxtInputField.copyWith(hintText: 'Create Password'),
                            style: TextStyle(fontSize: 17),
                            onChanged: (value){
                              password = value;
                            },  
                          ),

                        ],
                      )),
                      
                      SizedBox(height: 10,),
                      RaisedButton(
                        child: Text('Register',style: TextStyle(color: Colors.white,),),
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32)) ,
                        onPressed: ()async{ 
                          print(email);
                          print(password);

                          try {
                            final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email, 
                              password: password);
                            if (newUser!=null){
                              Navigator.pushNamed(context, ChatScreen().id);
                            }
                          } catch (e) {
                            print(e);
                          }

                          

                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}