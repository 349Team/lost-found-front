import 'package:flutter/material.dart';

import 'package:teste/screens/myObjectsList.dart';
import 'package:teste/services/api.dart';
import 'loginScreen.dart';
import 'package:teste/data/user.dart';
import 'package:teste/screens/lostObjectsList.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<ProfileScreen> {
  Future<String>? _value;
  final int screenId = 2;
  @override
  initState() {
    super.initState();
    _value = getValue(api.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 70,
                    child: DrawerHeader(
                      child: Row(
                        children: [
                          const Text(
                            'LOST&FOUND',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23.0,
                            ),
                          ),
                        ],
                      ),
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      margin: const EdgeInsets.all(0.0),
                      padding: const EdgeInsets.all(15.0),
                    ),
                  ),
                  ListTile(
                    title: const Text("Home"),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (screenId != 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LostObjectsList()),
                        );
                      }
                    },
                  ),
                  ListTile(
                    title: const Text("Profile"),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (screenId != 2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => ProfileScreen()),
                        );
                      }
                    },
                  ),
                  ListTile(
                    title: const Text("Meus objetos"),
                    leading: const Icon(Icons.emoji_objects),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (screenId != 3) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MyLostObjectsList()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.logout),
                    onTap: () {
                      api.logout(api.token);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<String>(
        future: _value,
        builder: (
          BuildContext context,
          AsyncSnapshot<String> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Center(
                  child: Text(
                    "Carregando perfil do usuário",
                    style: TextStyle(color: Colors.blue[700], fontSize: 28.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Esse Error');
            } else if (snapshot.hasData) {
              User user = User.fromJson(snapshot.data ?? "");

              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/icone.png'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(user.name),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.numbers),
                        title: Text(user.ra),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_city),
                        title: Text(user.campus),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(user.email),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {
                            api.logout(api.token);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sair',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
      ),
    );
  }
}

Future<String> getValue(String tokenR) async {
  return api.requestUserData();
}
