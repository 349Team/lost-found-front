import 'package:flutter/material.dart';
import 'package:teste/screens/addLostObject.dart';
import 'package:teste/screens/objectDetailsScreen.dart';
import "package:teste/data/lost_object_t1.dart";

class TesteTile2 extends StatelessWidget {
  VoidCallback function;
  final Objeto dados;
  Color _stateColor = Colors.green;
  String _state = "resolvido";
  TesteTile2(this.dados, this.function) {
    if (dados.status == "FOUND") {
      _state = "objeto encontrado";
      _stateColor = _stateColor = Colors.blue;
    }
    if (dados.status == "LOST") {
      _state = "objeto perdido";
      _stateColor = _stateColor = Colors.red;
    }
  }

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
                child: Image.network(
                  dados.image,
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        dados.title,
                        style: TextStyle(
                          color: Colors.black, //Theme.of(context).primaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _state,
                        style: TextStyle(
                          color: _stateColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dados.description,
                        style: TextStyle(fontSize: 15),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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

void fazNada() {}
