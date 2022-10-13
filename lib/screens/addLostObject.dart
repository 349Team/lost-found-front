import 'package:flutter/material.dart';

class AddLostObject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("ADD OBJETO"),
        ),
        body: Container(
            child: Center(
          child: Text("TELA ACRESCENTA OBJETOS"),
        )));
  }
}
