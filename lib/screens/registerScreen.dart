import 'package:flutter/material.dart';
import 'package:teste/screens/loginScreen.dart';
import 'package:teste/screens/lostObjectsList.dart';
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
  //User? usuario;

  var snackBarSuccess = SnackBar(
    content: Text(
      'Agora digite suas credenciais para continuar.',
      style: TextStyle(fontSize: 17),
    ),
    backgroundColor: Colors.blue,
  );

  var snackBarError = SnackBar(
    content: Text(
      'Um erro aconteceu no cadastro.',
      style: TextStyle(fontSize: 17),
    ),
    backgroundColor: Colors.red,
  );

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
                      hintText: 'Insira seu RA'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _campusController,
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Campus',
                      hintText: 'Insira seu campus'),
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
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
              SizedBox(height: 10),
              Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(15)),
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
                    if (await register(usuario) == SimpleResponse.ok) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBarSuccess);
                      await Future.delayed(Duration(milliseconds: 50));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    } else {
                      if (!_isSnackbarActive) {
                        _isSnackbarActive = true;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarError)
                            .closed
                            .then((SnackBarClosedReason reason) =>
                                {_isSnackbarActive = false});
                      }
                    }
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

Future<SimpleResponse> register(User user) async {
  //await Future.delayed(Duration(seconds: 2));
  return api.createUser(user);
}
