import 'package:flutter/material.dart';
import "dart:convert";
//import 'package:teste/data/dadosObjeto.dart';
//import 'package:teste/data/lost_object_model.dart';
import 'package:teste/data/lost_objects_t1.dart';
import 'package:teste/screens/myObjectsList.dart';
import 'package:teste/testeTile2.dart';
import 'package:teste/screens/addLostObject.dart';
import 'package:teste/screens/profileScreen.dart';
import 'package:teste/services/api.dart';

class LostObjectsList extends StatefulWidget {
  LostObjectsList({Key? key}) : super(key: key);

  @override
  _LostObjectsList createState() => _LostObjectsList();
}

class _LostObjectsList extends State<LostObjectsList> {
  _LostObjectsList();

  //final jsonData = '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';

  Future<String>? _value;
  final int screenId = 1;
  //LostObjectModel? objetos = null;
  //String titulo = "Lost + Found";
  void atualizarTela() {
    print("CHAMOU");
    setState(() {
      _value = getValue();
      //titulo = "MUDOU";
    });
  }

  @override
  initState() {
    super.initState();
    _value = getValue();
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
                  "Carregando lista de objetos.",
                  style: TextStyle(color: Colors.blue[700], fontSize: 28.0),
                  textAlign: TextAlign.center,
                ))
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Esse Error');
            } else if (snapshot.hasData) {
              LostObjectsT1 objetos =
                  LostObjectsT1.fromJson(snapshot.data ?? "");
              int tamanho = objetos.listaObjetos.length;
              //var teste = json.decode("");
              /*if (snapshot.data == SimpleResponse.ok) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => AddLostObject()));
              }*/
              return Column(
                children: <Widget>[
                  /*Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(
                children: <Widget>[
                  RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("ADD"),
                      textColor: Colors.white,
                      onPressed: fazNada)
                ],
              ),
            ),*/
                  Expanded(
                      child: ListView.separated(
                          padding: EdgeInsets.only(top: 10.0),
                          itemCount: objetos.listaObjetos.length,
                          separatorBuilder: (context, index) => SizedBox(
                                height: 7,
                              ),
                          itemBuilder: (context, index) {
                            //final parsedJson = jsonDecode(jsonData);

                            // objetos.listaDeObjetos.elementAt(index);
                            /* DadosObjeto objeto = new DadosObjeto(
                          parsedJson["objetos"][index]["nome"],
                          parsedJson["objetos"][index]["descricao"],
                          index,
                          parsedJson["objetos"][index]["status"],
                          parsedJson["objetos"][index]["link"]);*/
                            return TesteTile2(
                                objetos!.listaObjetos
                                    .elementAt((tamanho - 1) - index),
                                atualizarTela);
                          }))
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
          child: Icon(Icons.add),
          onPressed: () {
            //atualizarTela();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddLostObject()))
                .then((value) {
              setState(() {
                _value = getValue();
              });
            });
          }),
      appBar: AppBar(
          title: Text("LOST&FOUND"),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: false,
          actions: [Image.asset('assets/icone2.png')]),
    );
  }
}

/*Future<String> requestList(String token) {
  return requestLostObjectsList(token);
}*/

Future<String> getValue() async {
  //await Future.delayed(Duration(seconds: 2));
  return api.requestLostObjectsList(api.token);
  //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
}

void fazNada() {}
