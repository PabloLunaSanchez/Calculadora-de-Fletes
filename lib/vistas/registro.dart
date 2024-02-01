import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyectotrailer/services/auth_services.dart';
import 'package:proyectotrailer/services/globals.dart';
import 'package:proyectotrailer/vistas/login_vista/login/login.dart';
import 'package:proyectotrailer/vistas/mapa.dart';
import 'package:http/http.dart' as http;
import 'package:proyectotrailer/vistas/userprofile.dart';

import '../services/usuario.dart';
import '../services/usuariomanager.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);
  @override
  State<RegistroPage> createState() => _RegistrPageState();
}

String _nombre = "";
String _correo = "";
String _password = "";
String _telefono = "";
String _edad = "";
String _categoria = "";

class _RegistrPageState extends State<RegistroPage> {
  createAccountPressed() async {
    EasyLoading.show(); // Mostrar el indicador de carga

    bool emailValid = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(_correo);

    if (emailValid) {
      try {
        http.Response response = await AuthServices.register(
          _nombre,
          _correo,
          _password,
          _telefono,
          _edad,
          _categoria,
        );

        Map responseMap = jsonDecode(response.body);

        if (response.statusCode == 200) {
          await Future.delayed(
              Duration(seconds: 1)); // Agrega un retraso de 1 segundo

          // Si la cuenta se ha creado con éxito
          EasyLoading.dismiss();

          // Guardar la información del usuario
          Usuario usuario = Usuario(_nombre, _correo);
          await UsuarioManager.guardarUsuario(usuario);

          EasyLoading.showSuccess('Cuenta creada con éxito');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MapPageScreen(),
            ),
          );
        } else {
          EasyLoading.dismiss();
          errorSnackBar(context, responseMap.values.first[0]);
        }
      } catch (e) {
        EasyLoading.dismiss();
        errorSnackBar(context, 'Error en la solicitud');
      }
    } else {
      EasyLoading.dismiss();
      errorSnackBar(context, 'Correo no válido');
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
                          hintText: 'nombre',
                        ),
                        onChanged: (value) {
                          _nombre = value;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

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
                //contrseña
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
                          hintText: 'telefono',
                        ),
                        onChanged: (value) {
                          _telefono = value;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

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
                          hintText: 'edad',
                        ),
                        onChanged: (value) {
                          _edad = value;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                          hintText: '¿categoria admin o conductor?',
                        ),
                        onChanged: (value) {
                          _categoria = value;
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

                // Botón de registro
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      createAccountPressed();
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
                          'Registrate',
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
                      "Ya tienes una cuenta? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Inicia sesion aqui",
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

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserProfile userProfile = UserProfile(
    nombre: "",
    correo: "",
    password: "",
    telefono: "",
  );
  void saveChanges() {
    // Aquí puedes implementar la lógica para guardar los cambios.
    // Por ejemplo, puedes enviar los datos al servidor o almacenarlos localmente.

    // Ejemplo de impresión para demostrar cómo acceder a los datos del perfil.
    print("Nombre: ${userProfile.nombre}");
    print("Correo: ${userProfile.correo}");
    print("Contraseña: ${userProfile.password}");
    print("Telefono: ${userProfile.telefono}");
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MapPageScreen()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "Editar Perfil",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "images/admin.png"), // Reemplaza "tu_imagen.png" con la ruta correcta de tu imagen
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                buildTextField("Nombre", _nombre, false),
                buildTextField("Correo", _correo, false),
                buildTextField("Contraseña", _password, true),
                buildTextField("Telefono", _telefono, false),
                SizedBox(
                  height: 35,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      ElevatedButton(
                        onPressed: saveChanges,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepOrange),
                        ),
                        child: Text('Guardar'),
                      ),
                    ])
              ],
            )),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onChanged: (value) {
          setState(() {
            if (labelText == "Nombre") {
              userProfile.nombre = value;
            } else if (labelText == "Correo") {
              userProfile.correo = value;
            } else if (labelText == "Contraseña") {
              userProfile.password = value;
            } else if (labelText == "Telefono") {
              userProfile.telefono = value;
            }
          });
        },
      ),
    );
  }
}
