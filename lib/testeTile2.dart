import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:teste/data/lost_object.dart';
import 'package:teste/screens/addLostObject.dart';
import 'package:teste/screens/objectDetailsScreen.dart';
//import 'package:teste/data/lost_object.dart';
import "package:teste/data/lost_object_t1.dart";

class TesteTile2 extends StatelessWidget {
  VoidCallback function;
  final Objeto dados;
  TesteTile2(this.dados, this.function);

  @override
  Widget build(BuildContext context) {
    void _completeLogin() {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AddLostObject(),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => ObjectDetailsScreen(dados),
                  ),
                )
                .then((value) => function());
          },
          child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: dados.getCor(), width: 3),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: 130,
                    child: Container(
                        //flex: 1,
                        child: Image.network(
                      dados.image,
                      fit: BoxFit.cover,
                      height: 150.0,
                    )),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dados.title,
                            style: TextStyle(
                                color: Colors
                                    .black, //Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dados.description,
                            style: TextStyle(fontSize: 15),
                            maxLines: 2,
                          ),
                          /*Text(
                            "TEXTO3",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}

void fazNada() {}
