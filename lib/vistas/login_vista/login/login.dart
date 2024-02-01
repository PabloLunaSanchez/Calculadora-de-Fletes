import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyectotrailer/services/auth_services.dart';
import 'package:proyectotrailer/services/globals.dart';
import 'package:proyectotrailer/vistas/mapa.dart';
import 'package:http/http.dart' as http;
import 'package:proyectotrailer/vistas/olvidarcontrase%C3%B1aemail.dart';
import 'package:proyectotrailer/vistas/registro.dart';

import '../../../services/usuario.dart';
import '../../../services/usuariomanager.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
      ),
      body: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _correo = "";
  String _password = "";

  LoginPressed() async {
    if (_correo.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_correo, _password);
      Map responseMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const MapPageScreen(),
          ),
        );
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, "Ingrese todos los campos requeridos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF83C6f6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'B I E N V E N I D O  A ',
                  style: TextStyle(
                      color: Color(0xFFF1F8FE),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Text(
                  'T R A C K E R  T R U C K ',
                  style: TextStyle(
                      color: Color(0xFFF1F8FE),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                SizedBox(height: 20),
                Image.network(
                  ('https://static.wixstatic.com/media/8de586_97a501e24e0b47da85d08c3cd7e2a44c~mv2.png/v1/fill/w_585,h_391,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/mexico.png'), // Ajusta la ruta de la imagen según tu proyecto
                ),
                //correo

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F8FE),
                      border: Border.all(color: Color(0xFF83C6F6)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'correo',
                        ),
                        onChanged: (value) {
                          _correo = value;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //contrseña
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F8FE),
                      border: Border.all(
                        color: Color(0xFF83C6F6),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'contraseña',
                        ),
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),

                // Botón de Login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      LoginPressed();
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF0C71BD),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿No tienes una cuenta? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistroPage()),
                        );
                      },
                      child: Text(
                        "Registrate aqui",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿olvidaste tu contraseña? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OlvidarContraEmailScreen()),
                        );
                      },
                      child: Text(
                        "Recuperar contraseña",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
