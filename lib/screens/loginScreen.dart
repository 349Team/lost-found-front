import 'package:flutter/material.dart';
import 'package:teste/screens/lostObjectsList.dart';
import 'package:teste/screens/registerScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size:
    MediaQuery.of(context).size; //getting the size property
    orientation:
    MediaQuery.of(context).orientation; //getting the orientation
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // child: Container(
                child: Image.asset(
                  'assets/icone.png',
                  fit: BoxFit.cover,
                ),
                // ),
              ),
              // SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Usuário',
                      hintText: 'Digite seu email'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Colors.red,
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      hintText: 'Digite sua senha'),
                ),
              ),

              Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(15)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LostObjectsList()),
                    );
                  },
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Não tem uma conta?",
                    style: TextStyle(
                      color: Color(0xFFb8b8b8),
                    ),
                  ),
                  TextButton(
                    child: Text("Registre-se"),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

