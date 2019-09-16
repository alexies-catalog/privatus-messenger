import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:privatus/constants/design_constants.dart';
import 'package:privatus/components/txtfield_rounded.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
                      Image(
                        image: AssetImage('images/logo_150.png'),
                        width: 80,
                      ),
                
    
                      ColorizeAnimatedTextKit(
                        onTap: () {
                            print("Tap Event");
                          },
                        text: [
                          "LOGIN",
                        ],
                        textStyle: TextStyle(
                            fontSize: 40.0, 
                            fontFamily: "Horizon",
                            fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Colors.red,
                          Colors.redAccent,
                      
                        ],
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                      ),

                      // SizedBox(height: 10,),
                      //(hinttext,passchar,keyboardtype)
                      Container(width: 200, child: Column(
                        children: <Widget>[
                          RoundedTxtField('Insert Email Address',false,),
                          SizedBox(height: 15,),
                          RoundedTxtField('Insert Password',true,),
                        ],
                      )),
                      
                      SizedBox(height: 10,),
                      RaisedButton(
                        child: Text('Login'),
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32)) ,
                        onPressed: (){ 
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



