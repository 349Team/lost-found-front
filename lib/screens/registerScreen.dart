import 'package:flutter/material.dart';
import 'package:teste/screens/loginScreen.dart';
import 'package:teste/screens/lostObjectsList.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _raController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size:
    MediaQuery.of(context).size; //getting the size property
    orientation:
    MediaQuery.of(context).orientation; //getting the orientation
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Lost + Found"),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   centerTitle: false,
      //   actions: [
      //     Image.asset('assets/icone2.png'),
      //   ],
      // ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                child: Text(
                  'Criando um conta',
                  style: TextStyle(color: Colors.blue[900], fontSize: 30),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  // autofocus: true,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                      hintText: 'Insira seu nome completo'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _raController,
                  keyboardType: TextInputType.number,
                  maxLength: 7,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'RA',
                      hintText: 'Enter your RA'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Digite um email válido'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      hintText: 'Digite uma senha'),
                ),
              ),
              SizedBox(height: 10),
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
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                child: Text(
                  'Já tem uma conta?',
                  style: TextStyle(color: Colors.blue[900], fontSize: 15),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

