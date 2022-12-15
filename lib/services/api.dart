import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste/services/login.dart';
import 'package:teste/data/user.dart';
import "package:teste/data/lost_object_t1.dart";
import 'package:image_picker/image_picker.dart';

enum SimpleResponse { ok, error }

class API {
  int id = 0;
  String token = "";

  void logger(String x) {
    debugPrint('print: $x');
  }

  int getId() {
    return id;
  }

  String getToken() {
    return token;
  }

  Future<SimpleResponse> verifyToken() async {
    //logger("API::verifyToken::init");
    var reqUrl = Uri.parse('https://lost-found-api.fly.dev/auth/me');

    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var reqBody = jsonEncode(<String, String?>{'token': this.token});

    var response = await http.post(reqUrl, headers: reqHeaders, body: reqBody);

    if (response.statusCode == 200) {
      //logger("API::verifyToken::ok");
      return SimpleResponse.ok;
    } else {
      //logger("API::login::error on (token: ${this.token}");
      return SimpleResponse.error;
    }
    ;
  }

  Future<String> login(String ra, String password) async {
    //logger("API::login::init with (email: $ra, password: $password)");
    var reqUrl = Uri.parse('https://lost-found-api.fly.dev/auth/login');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var reqBody = jsonEncode(<String, String>{'ra': ra, 'password': password});

    var response = await http.post(reqUrl, headers: reqHeaders, body: reqBody);

    if (response.statusCode == 200) {
      //logger("API::login::ok on (email: $ra, password: $password)");
      var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      this.id = resBody.id;
      this.token = resBody.token;
      //logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      return resBody.token;
    } else {
      //logger("API::login::error on (email: $ra, password: $password)");
      return "ERRO";
    }
  }

  Future<String> requestLostObjectsList(String busca) async {
    //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
    //logger("API::requestLostObjects::init with (token: $token)");
    Uri reqUrl;
    if (busca == "") {
      reqUrl = Uri.parse('https://lost-found-api.fly.dev/object');
    } else {
      reqUrl = Uri.parse('https://lost-found-api.fly.dev/object/search/$busca');
    }
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    //var reqBody = jsonEncode(<String, String>{'token': token});

    var response = await http.get(reqUrl, headers: reqHeaders);

    if (response.statusCode == 200) {
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      //logger("API::requestLostObjects::ok on (token: $token)");
      //var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      //this.id = resBody.id;
      //this.token = resBody.token;
      //logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      var content = response.body;
      //logger("----------------------API::resuqestList::body = $content");
      //return '{"objects":[{"id":1,"title":"Garrafinha de Água","description":"Garrafinha perdida no bloco B","owner":1,"discoverer":null,"location":"UTPPR-CM, bloco B","type":"LOST","status":"LOST","images":["https://lost-found-api.fly.dev/images/image/1"],"image":"https://lost-found-api.fly.dev/images/image/1","tags":[{"id":1,"title":"garrafinha"},{"id":3,"title":"material escolar"}]}]}';
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      return response.body;
      //return SimpleResponse.ok;
    } else {
      //logger("API::requestLostObjects::error on (token: $token)");
      return "SimpleResponse.error";
    }
    //return response.body;*/
  }

  Future<String> requestLostObjectsList_byUser(int id) async {
    //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
    //logger("API::requestLostObjects::init with (token: $token)");
    var reqUrl = Uri.parse('https://lost-found-api.fly.dev/object/user/$id');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    //var reqBody = jsonEncode(<String, String>{'token': token});

    var response = await http.get(reqUrl, headers: reqHeaders);

    if (response.statusCode == 200) {
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      //logger("API::requestLostObjects::ok on (token: $token)");
      //var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      //this.id = resBody.id;
      //this.token = resBody.token;
      //logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      var content = response.body;
      //logger("----------------------API::resuqestList::body = $content");
      //return '{"objects":[{"id":1,"title":"Garrafinha de Água","description":"Garrafinha perdida no bloco B","owner":1,"discoverer":null,"location":"UTPPR-CM, bloco B","type":"LOST","status":"LOST","images":["https://lost-found-api.fly.dev/images/image/1"],"image":"https://lost-found-api.fly.dev/images/image/1","tags":[{"id":1,"title":"garrafinha"},{"id":3,"title":"material escolar"}]}]}';
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      return response.body;
      //return SimpleResponse.ok;
    } else {
      //logger("API::requestLostObjects::error on (token: $token)");
      return "SimpleResponse.error";
    }
    //return response.body;*/
  }

  Future<String> createUser(User user) async {
    //logger(user.toJson());
    var reqUrl = Uri.parse('https://lost-found-api.fly.dev/user');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    var reqBody = jsonEncode(<String, String>{
      "ra": user.ra,
      "password": user.senha,
      "fullName": user.name,
      "email": user.email,
      "campus": user.campus
    });

    var response = await http.post(reqUrl, headers: reqHeaders, body: reqBody);

    if (response.statusCode == 200) {
      //var resBody = jsonDecode(response.body);
      //logger(
      //    "API::createUser::success - (ra: ${resBody['ra']}, id: ${resBody['id']})\n\n");
      return "OK";
    } else {
      var resBody = jsonDecode(response.body);
      //logger("API::createUser::erro: ${resBody['message']}\n\n");
      if (resBody['message'] == "Conflict: user already exists") {
        return "1";
      } else {
        return "ERRO";
      }
    }
  }

  Future<SimpleResponse> sendImage(XFile? imagem, int id) async {
    //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
    //logger("API::requestSendImage::init with (token: $token)");

    String imagePath = imagem!.path + ".jpg";

    //logger("API::requestSendImage::path: $imagePath\n");

    var postHeaders = <String, String>{'Authorization': token};

    var sendImageUrl =
        Uri.parse('https://lost-found-api.fly.dev/object/images/$id');

    var requestPostImage = http.MultipartRequest('POST', sendImageUrl);

    requestPostImage.headers.addAll(postHeaders);

    requestPostImage.files.add(http.MultipartFile(
        'image', imagem!.readAsBytes().asStream(), await imagem!.length(),
        filename: imagePath.split("/").last));

    var response = await requestPostImage.send();

    var __data = await http.Response.fromStream(response);
    var data = json.decode(__data.body);

    var stream = response.stream;

    if (response.statusCode == 200) {
      //logger("API::sendImage::ok");
      //var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      //this.id = resBody.id;
      //this.token = resBody.token;
      //logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      return SimpleResponse.ok;
      //return SimpleResponse.ok;
    } else {
      //logger("API::sendImage::error::$data['message']");
      return SimpleResponse.error;
    }
    //return response.body;
  }

  Future<SimpleResponse> registerNewObject(Objeto objeto, XFile? file) async {
    //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
    //logger("API::requestLostObjects::init with (token: $token)");
    var reqUrl = Uri.parse('https://lost-found-api.fly.dev/object');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    var reqBody = jsonEncode(<String, dynamic>{
      'title': objeto.title,
      'description': objeto.description,
      'ownerId': (objeto.type == "FOUND" ? null : id),
      'location': objeto.location,
      'type': objeto.type,
      'discovererId': (objeto.type == "FOUND" ? id : null),
      'tags': [1, 3]
    });

    var response = await http.post(reqUrl, headers: reqHeaders, body: reqBody);

    if (response.statusCode == 201) {
      var resposta = response.body;
      var jsonTemporario = json.decode(resposta);

      SimpleResponse imageResponse =
          await sendImage(file, jsonTemporario["id"]);
      if (imageResponse == SimpleResponse.error) {
        return SimpleResponse.error;
      }

      //logger("API::registerObject::ok + $response[body]");
      //var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      //this.id = resBody.id;
      //this.token = resBody.token;
      //logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      return SimpleResponse.ok;
      //return SimpleResponse.ok;
    } else {
      //logger("API::registerObject::error ");
      return SimpleResponse.error;
    }
    //return response.body;
  }

  Future<String> requestUserData({int input = -1}) async {
    if (input == -1) {
      input = api.id;
    }
    // print("ID = $input");
    //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
    //logger("API::requestUserData::init with (id: $id)");
    var reqUrl = Uri.parse('https://lost-found-api.fly.dev/user/$input');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    //var reqBody = jsonEncode(<String, String>{'token': token});

    var response = await http.get(reqUrl, headers: reqHeaders);

    if (response.statusCode == 200) {
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      //logger("API::requestUserData::ok on (token: $token)");
      //var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      //this.id = resBody.id;
      //this.token = resBody.token;
      //logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      var content = response.body;
      //logger("----------------------API::resuqestList::body = $content");
      //return '{"objetos":[{"id":1,"title":"Cachorro","description":"Cachorro perdido no bloco B","owner":1,"discoverer":null,"location":"UTPPR-CM, bloco B","type":"LOST","status":"ACTIVE","images":["https://lost-found-api.fly.dev/images/image/1"],"image":"https://lost-found-api.fly.dev/images/image/1","tags":[{"id":1,"title":"garrafinha"},{"id":3,"title":"material escolar"}]}]}';
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      return response.body;
      //return SimpleResponse.ok;
    } else {
      //logger("API::requestLostObjects::error on (token: $token)");
      return "SimpleResponse.error";
    }
    //return response.body;*/
  }

  void logout(String token) async {
    //logger("API::logout::init with (token: $token)");
    api.id = 0;
    api.token = "";
    //logger("API::logged out::init with (token: $token)");
  }

  Future<SimpleResponse> devolver(int id) async {
    //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
    //logger("API::requestLostObjects::init with (token: $token)");
    var reqUrl = Uri.parse('https://lost-found-api.fly.dev/object/finish/$id');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    var reqBody = jsonEncode(<String, dynamic>{});

    var response = await http.post(reqUrl, headers: reqHeaders, body: reqBody);

    if (response.statusCode == 200) {
      //logger("API::requestLostObjects::ok on (id: $id)");

      //var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      //this.id = resBody.id;
      //this.token = resBody.token;
      //logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      return SimpleResponse.ok;
      //return SimpleResponse.ok;
    } else {
      //logger("API::requestLostObjects::error on (id: $id)");
      // print("MENSAGEM DE ERRO: " + response.body);
      return SimpleResponse.error;
    }
    //return response.body;
  }

  Future<String> requestChatList(int idObjeto) async {
    //logger("API::requestChatList::init with (idObjeto: $idObjeto)");
    var reqUrl =
        Uri.parse('https://lost-found-api.fly.dev/message/info/$idObjeto');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    var response = await http.get(reqUrl, headers: reqHeaders);

    if (response.statusCode == 200) {
      // logger("API::requestChatList::ok on (idObjeto: $idObjeto)");
      var content = response.body;
      //logger("----------------------API::resuqestList::body = $content");
      return response.body;
    } else {
      // logger("API::requestChatList::error on (idObjeto: $idObjeto)");
      return "SimpleResponse.error";
    }
    //return response.body;*/
  }

  Future<String> requestChatMessages(int idObjeto, int requesterId) async {
    // logger(
    //    "API::requestChatMessages::init with (sender: $idObjeto, receiver: $requesterId)");
    var reqUrl = Uri.parse(
        'https://lost-found-api.fly.dev/message/list/$idObjeto/$requesterId');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    var response = await http.get(reqUrl, headers: reqHeaders);
    //print(response.body);
    if (response.statusCode == 200) {
      //  logger(
      //     "API::requestChatMessage::ok on (sender: $idObjeto, receiver: $requesterId)");
      var content = response.body;
      // logger("----------------------API::resuqestList::body = $content");
      return response.body;
    } else {
      // logger(
      //      "API::requestChatMessage::error on (sender: $idObjeto, receiver: $requesterId)");
      return "SimpleResponse.error";
    }
    //return response.body;*/
  }

  Future<SimpleResponse> sendMessage(
      String mensagem, int idObjeto, int idSender, int idRecipient) async {
    //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
    // logger("API::requestLostObjects::init with (token: $token)");
    var reqUrl = Uri.parse('https://lost-found-api.fly.dev/message/send');
    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    };

    var reqBody = jsonEncode(<String, dynamic>{
      "message": mensagem,
      "sender": api.id,
      "recipient": idRecipient,
      "object": idObjeto
    });

    var response = await http.post(reqUrl, headers: reqHeaders, body: reqBody);

    if (response.statusCode == 200) {
      // logger("API::requestLostObjects::ok on (id: $id)");

      //var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      //this.id = resBody.id;
      //this.token = resBody.token;
      //logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
      return SimpleResponse.ok;
      //return SimpleResponse.ok;
    } else {
      // logger("API::requestLostObjects::error on (id: $id)");
      // print(response.statusCode);
      return SimpleResponse.error;
    }
    //return response.body;
  }
}

var api = API();
