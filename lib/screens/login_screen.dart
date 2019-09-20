import 'package:flutter/material.dart';
// import 'package:privatus/components/txtfield_rounded.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:privatus/constants/design_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privatus/screens/chat_screen.dart';
import 'package:async/async.dart';
import 'package:privatus/screens/registration_screen.dart';


class LoginScreen extends StatefulWidget {
  
  String id= "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    password = null;

    emailController.text='ialexies@gmail.com';
    passwordController.text='123456';
    

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                       
                        // SizedBox(height: 30,),
                      
                        Image(
                          image: AssetImage('images/logo_150.png'),
                          width: 200,
                        ),
                  
                        SizedBox(height: 10,),
                        ColorizeAnimatedTextKit(
                          onTap: () {
                              print("Tap Event");
                            },
                          text: [
                            "Login to your account",
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

                 
                        Container(width: 200, child: Column(
                          children: <Widget>[
                
                       

                            TextFormField(
                              // initialValue: 'ialexies@gmail.com',
                              controller: emailController,
                              textAlign: TextAlign.center,
                              keyboardType:TextInputType.emailAddress,
                              decoration: GenTxtInputField.copyWith(hintText: 'Insert Email'),
                              style: TextStyle(fontSize: 17),
                              // onChanged: (value){
                              //   email = value;
                              // },  
                            ),
                            SizedBox(height: 15,),
                            TextFormField(

                              // initialValue: '123456',
                              controller: passwordController,
                              textAlign: TextAlign.center,
                              obscureText: true,
                              keyboardType:TextInputType.emailAddress,
                              decoration: GenTxtInputField.copyWith(hintText: 'Create Password'),
                              style: TextStyle(fontSize: 17),
                              // onChanged: (value){
                              //   password = value;
                              // },  
                            ),

                          ],
                        )),
                        
                        SizedBox(height: 10,),
                        RaisedButton(
                          child: Text('Login',style: TextStyle(color: Colors.white,),),
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32)) ,
                          onPressed: ()async{ 
                            print(email);
                            print(password);

                            setState(() {
                             showSpinner = true; 
                            });

                            try {
                              final loginUser = await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                      
                              if (loginUser!=null){
                                Navigator.pushNamed(context, ChatScreen().id);
                              }
                              setState(() {
                               showSpinner = false; 
                              });
                            } catch (e) {
                              print(e);
                              showSpinner = false; 
                            }
                            

                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: GestureDetector(
                            child: Text('REGISTER'),
                            onTap: (){
                                Navigator.pushNamed(context, RegistrationScreen().id);
                            },
                        
                       
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 