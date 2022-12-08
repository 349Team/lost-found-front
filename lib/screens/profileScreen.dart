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
    //LostObjectModel objetos = LostObjectModel.fromJson(jsonData);
    return Scaffold(
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          SizedBox(
              height: 70,
              child: DrawerHeader(
                  child: Row(
                    children: [
                      Text('LOST&FOUND',
                          style:
                              TextStyle(color: Colors.white, fontSize: 23.0)),
                      Spacer(),
                      Icon(Icons.search_off_outlined,
                          color: Colors.white, size: 33),
                    ],
                  ),
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(15.0))),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pop();
              if (screenId != 1)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LostObjectsList()),
                );
            },
          ),
          ListTile(
            title: Text("Profile"),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.of(context).pop();
              if (screenId != 2)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen()),
                );
            },
          ),
          ListTile(
            title: Text("Meus objetos"),
            leading: Icon(Icons.emoji_objects),
            onTap: () {
              Navigator.of(context).pop();
              if (screenId != 3)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MyLostObjectsList()),
                );
            },
          ),
        ]),
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
              //mainAxisAlignment: MainAxisAlignment.center,
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
                ))
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
                      // SizedBox(height: 100),
                      // Expanded(child:
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          color: Colors.blue[900],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
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
                                      color: Colors.black.withOpacity(0.1))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/icone.png'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        // onTap: () {},
                        leading: Icon(Icons.person),
                        title: Text(user.name),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        // onTap: () {},
                        leading: Icon(Icons.numbers),
                        title: Text(user.ra),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        // onTap: () {},
                        leading: Icon(Icons.location_city),
                        title: Text(user.campus),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text(user.email),
                        // dense: true,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          onPressed: () {
                            api.logout(api.token);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                          child: Text(
                            'Sair',
                            style: TextStyle(color: Colors.white, fontSize: 23),
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
        title: Text("Perfil"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
      ),
    );
  }
}

Future<String> getValue(String tokenR) async {
  //await Future.delayed(Duration(seconds: 2));
  return api.requestUserData();
  //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
}
