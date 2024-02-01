import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyectotrailer/services/globals.dart';

class AuthServices {
  static Future<http.Response> register(String nombre, String correo,
      String password, String telefono, String edad, String categoria) async {
    Map data = {
      "nombre": nombre,
      "correo": correo,
      "password": password,
      "telefono": telefono,
      "edad": edad,
      "categoria": categoria,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/register');
    http.Response response = await http.post(url, headers: headers, body: body);
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String correo, String password) async {
    Map data = {
      "correo": correo,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(url, headers: headers, body: body);
    print(response.body);
    return response;
  }
}
