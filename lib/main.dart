import 'package:flutter/material.dart';
import 'package:teste/screens/addLostObject.dart';
import 'package:teste/screens/chat/screens/chat_screen.dart';
import 'package:teste/screens/loginScreen.dart';
import 'package:teste/screens/lostObjectsList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawer and Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[900],
      ),
      home: LoginScreen(),
    );
  }
}

void fazNada() {
  int t = 10;
}
