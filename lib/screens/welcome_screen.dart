import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:privatus/constants/design_constants.dart';
import 'package:privatus/components/txtfield_rounded.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:privatus/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  String id = "welcome_screen";


  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQueryData;
    double screenWidth = MediaQuery.of(context).size.width;

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
                      // Image(
                      //   image: AssetImage('images/logo_150.png'),
                      //   width: 80,
                      // ),
                
                      SizedBox(height: 20,),
    
                      ColorizeAnimatedTextKit(
                        onTap: () {
                            print("Tap Event");
                          },
                        text: [
                          "Welcome to \nPrivatus Messenger",
                        ],
                        textStyle: TextStyle(
                            fontSize: 30.0, 
                            fontFamily: "Horizon",
                            fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Colors.red,
                          Colors.redAccent,
                      
                        ],
                        textAlign: TextAlign.center,
                        alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                      ),

                  
                
                      
                      SizedBox(height: 10,),
                      RaisedButton(
                        child: Text('Login'),
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32)) ,
                        onPressed: (){ 
                          Navigator.pushNamed(context, LoginScreen().id );
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



