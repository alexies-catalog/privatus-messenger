import 'package:flutter/material.dart';
import 'package:privatus/constants/design_constants.dart';

class RoundedTxtField extends StatelessWidget {

  RoundedTxtField(this.txttitle,this.passChar);

  final String txttitle;
  final bool passChar;
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: passChar,
      keyboardType:TextInputType.emailAddress,
      decoration: GenTxtInputField.copyWith(hintText: txttitle),
    
    );
  }
}