import 'package:flutter/material.dart';
import 'package:teste/screens/lostObjectsList.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final jsonData =
      '{"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _completeLogin();
            }),
        appBar: AppBar(
          title: Text("LOGIN"),
        ),
        body: Container(
            child: Center(
          child: Text("TELA DE LOGIN"),
        )));
  }

  void _completeLogin() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LostObjectsList(),
      ),
    );
  }
}
