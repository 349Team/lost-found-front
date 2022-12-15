import 'package:flutter/material.dart';

import 'package:teste/data/lost_objects_t1.dart';
import 'package:teste/widgets/testeTile2.dart';
import 'package:teste/screens/addLostObject.dart';
import 'package:teste/screens/profileScreen.dart';
import 'package:teste/services/api.dart';
import 'package:teste/screens/lostObjectsList.dart';
import 'loginScreen.dart';

class MyLostObjectsList extends StatefulWidget {
  MyLostObjectsList({Key? key}) : super(key: key);
  @override
  _LostObjectsList createState() => _LostObjectsList();
}

class _LostObjectsList extends State<MyLostObjectsList> {
  _LostObjectsList();

  Future<String>? _value;
  final int screenId = 3;

  void atualizarTela() {
    setState(() {
      _value = getValue();
    });
  }

  @override
  initState() {
    super.initState();
    _value = getValue();
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
                      atualizarTela();
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
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Center(
                  child: Text(
                    "Carregando lista de objetos.",
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
              LostObjectsT1 objetos =
                  LostObjectsT1.fromJson(snapshot.data ?? "");
              int tamanho = objetos.listaObjetos.length;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 10.0),
                      itemCount: objetos.listaObjetos.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 7,
                      ),
                      itemBuilder: (context, index) {
                        return TesteTile2(
                            objetos.listaObjetos
                                .elementAt((tamanho - 1) - index),
                            atualizarTela);
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddLostObject(),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Lost + Found"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        actions: [
          Image.asset('assets/icone2.png'),
        ],
      ),
    );
  }
}

Future<String> getValue() async {
  return api.requestLostObjectsList_byUser(api.id);
}
