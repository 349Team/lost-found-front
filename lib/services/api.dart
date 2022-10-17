import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste/services/login.dart';

enum SimpleResponse {
  ok,
  error
}

class API {
  int? id;
  String? token;

  void logger(String x) {
    debugPrint('print: $x');
  }

  Future<SimpleResponse> verifyToken() async {
    logger("API::verifyToken::init");
    var reqUrl = Uri.parse('http://10.0.2.2:3030/auth/me');

    var reqHeaders = <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var reqBody = jsonEncode(<String, String?>{
      'token': this.token
    });

    var response =  await http.post(reqUrl, headers: reqHeaders, body: reqBody);

    if(response.statusCode == 200){
      logger("API::verifyToken::ok");
      return SimpleResponse.ok;
    }else {
      logger("API::login::error on (token: ${this.token}");
      return SimpleResponse.error;
    };
  }

  Future<SimpleResponse> login(String email, String password) async {
    logger("API::login::init with (email: $email, password: $password)");
    var reqUrl = Uri.parse('http://10.0.2.2:3030/auth/login');
    var reqHeaders = <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var reqBody = jsonEncode(<String, String>{
      'email': 'userOne@email.com',
      'password': 'userOnePass'
    });

    var response =  await http.post(reqUrl, headers: reqHeaders, body: reqBody);

    if(response.statusCode == 200){
      logger("API::login::ok on (email: $email, password: $password)");
      var resBody = LoginResponse.fromJson(jsonDecode(response.body));
      this.id = resBody.id;
      this.token = resBody.token;
      logger("API::login::saving-data (id: ${this.id}, token: ${this.token})");
      return SimpleResponse.ok;
    }else {
      logger("API::login::error on (email: $email, password: $password)");
      return SimpleResponse.error;
    };
  }
}

var api = API();