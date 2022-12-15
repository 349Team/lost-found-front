import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:teste/screens/loginScreen.dart';
import 'package:teste/data/user.dart';
import 'package:teste/services/api.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _raController = TextEditingController();
  final _campusController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isSnackbarActive = false;

  var snackBarSuccess = SnackBar(
    content: const Text(
      'Agora digite suas credenciais para continuar.',
      style: TextStyle(fontSize: 17),
    ),
    backgroundColor: Colors.blue,
  );

  var snackBarError = const SnackBar(
    content: Text(
      'Um erro aconteceu no cadastro.',
      style: TextStyle(fontSize: 17),
    ),
    backgroundColor: Colors.red,
  );

  var snackBarErrorCadastro = const SnackBar(
    content: Text(
      'ERRO! Usuário já cadastrado.',
      style: TextStyle(fontSize: 17),
    ),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                'Criando um conta',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                    hintText: 'Insira seu nome completo',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _raController,
                  keyboardType: TextInputType.number,
                  maxLength: 7,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'RA',
                    hintText: 'Insira seu RA',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _campusController,
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Campus',
                    hintText: 'Insira seu campus',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Digite um email válido',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                    suffixIcon: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: (_obscureText == true)
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () async {
                    var tempMap = {
                      "fullName": _nameController.text,
                      "ra": _raController.text,
                      "campus": _campusController.text,
                      "email": _emailController.text,
                      "password": _passwordController.text
                    };

                    User usuario = User.fromMap(tempMap);
                    String response = await register(usuario);
                    if (response == "OK") {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBarSuccess);
                      await Future.delayed(
                        const Duration(milliseconds: 50),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    } else {
                      if (!_isSnackbarActive) {
                        _isSnackbarActive = true;
                        //print(response);
                        if (response == "1") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarErrorCadastro)
                              .closed
                              .then((SnackBarClosedReason reason) =>
                                  {_isSnackbarActive = false});
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarError)
                              .closed
                              .then((SnackBarClosedReason reason) =>
                                  {_isSnackbarActive = false});
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> register(User user) async {
  return api.createUser(user);
}
