import 'package:flutter/material.dart';
import 'package:teste/screens/lostObjectsList.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _tLogin = TextEditingController();
  final _tPassword = TextEditingController();

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
              // Text(
              //   'Last + Found',
              //   style: TextStyle(color: Colors.blue[900], fontSize: 30),
              // ),
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
                  controller: _tLogin,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter a valid email'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _tPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password'),
                ),
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     'Forgot password?',
              //     style: TextStyle(color: Colors.blue[900], fontSize: 15),
              //   ),
              // ),

              Container(
                height: 50,
                width: 200,
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
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
