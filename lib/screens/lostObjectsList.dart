import 'package:flutter/material.dart';
//import 'package:teste/data/dadosObjeto.dart';
import 'package:teste/data/lost_object_model.dart';
import 'package:teste/testeTile2.dart';
import 'dart:convert';
import 'package:teste/screens/addLostObject.dart';

class LostObjectsList extends StatefulWidget {
  LostObjectsList({Key? key}) : super(key: key);

  @override
  _LostObjectsList createState() => _LostObjectsList();
}

class _LostObjectsList extends State<LostObjectsList> {
  final jsonData =
      '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';

  @override
  Widget build(BuildContext context) {
    LostObjectModel objetos = LostObjectModel.fromJson(jsonData);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddLostObject()));
            }),
        appBar: AppBar(
            title: Text("Lost + Found"),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: false,
            actions: [Image.asset('assets/icone2.png')]),
        body: Column(
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
                    itemCount: objetos.listaDeObjetos.length,
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
                          objetos.listaDeObjetos.elementAt(index));
                    }))
          ],
        ));
  }
}

void fazNada() {}
