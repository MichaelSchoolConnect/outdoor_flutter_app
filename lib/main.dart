import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outdoor_flutter_app/ui/signup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    title: 'Current',
    home: SignUpScreen(),
  ));
}
