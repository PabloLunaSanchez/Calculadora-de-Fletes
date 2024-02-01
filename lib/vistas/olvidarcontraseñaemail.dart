import 'package:flutter/material.dart';
import 'package:proyectotrailer/vistas/olvidarcontrase%C3%B1aContra.dart';

class OlvidarContraEmailScreen extends StatelessWidget {
  const OlvidarContraEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 122, 171),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {
                //que lleve de regreso al login
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.56,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/trailer.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromARGB(
                            255, 63, 122, 171), // Primer color (transparent)
                        Colors.transparent, // Segundo color (transparent)
                      ],
                    ),
                  ),
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'TRUCK\t',
                            style: TextStyle(
                              fontFamily: "Bebas",
                              fontSize: 25,
                              letterSpacing: 5,
                            ),
                            children: [
                              TextSpan(
                                text: 'TRACKER',
                                style: TextStyle(color: Colors.blue[300]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height:
                                10), // Espacio adicional antes de "Forget password"
                        Text(
                          "Olvido su contraseña?",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height:
                                10), // Espacio adicional antes del texto de correo electrónico
                        Text(
                          "Por favor ingrese su correo asociado a su cuenta",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height:
                                280), // Espacio adicional antes del campo de correo electrónico
                        // Campo para ingresar el correo
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Correo electrónico',
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                            height:
                                20), // Espacio adicional entre el campo de correo y el botón "Continuar"
                        // Botón "Continuar"
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OlvidarContraContraScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Continuar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
