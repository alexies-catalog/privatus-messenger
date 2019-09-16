
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