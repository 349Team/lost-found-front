import 'package:flutter/material.dart';
import 'package:teste/screens/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lost&Found',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[900],
      ),
      home: LoginScreen(),
    );
  }
}
