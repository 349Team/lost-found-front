import 'package:flutter/material.dart';

class DadosObjeto {
  final String nome;
  final String descricao;
  final int numero;
  final int estado;
  final String link;
  var _cor;

  DadosObjeto(this.nome, this.descricao, this.numero, this.estado, this.link) {
    _cor = {1: Colors.red, 2: Colors.blue, 3: Colors.green} ?? Colors.black;
    /*switch (estado) {
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
  }*/
  }
  Color getCor() {
    return _cor[estado];
  }
}
