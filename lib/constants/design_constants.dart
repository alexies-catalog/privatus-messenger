
import 'package:flutter/material.dart';

const GenTxtInputField =InputDecoration(
  contentPadding: EdgeInsets.all(8),
  hintText: 'Enter a Value',
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amber),
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amberAccent),
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
);


const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.white70,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
 
);