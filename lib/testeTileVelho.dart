import 'package:flutter/material.dart';
import 'package:teste/data/dadosObjetoVelho.dart';

class TesteTile extends StatelessWidget {
  final DadosObjeto dados;
  Color _cor = Colors.black;
  TesteTile(this.dados) {
    {
      switch (dados.estado) {
        case 1:
          {
            _cor = Colors.red;
          }
          break;
        case 2:
          {
            _cor = Colors.blue;
          }
          break;
        default:
          {
            _cor = Colors.green;
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: _cor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 180,
        child: Center(
            child: ListTile(

                /*shape: RoundedRectangleBorder(
                    side: BorderSide(width: 3, color: _cor),
                    borderRadius: BorderRadius.circular(10)),*/
                title: Text(dados.nome),
                leading: Image.network(dados.link, fit: BoxFit.fitWidth),
                //trailing: Icon(Icons.keyboard),
                subtitle: Text(dados.descricao))));
  }
}
