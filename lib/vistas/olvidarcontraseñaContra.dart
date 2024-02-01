import 'package:flutter/material.dart';

class OlvidarContraContraScreen extends StatefulWidget {
  const OlvidarContraContraScreen({Key? key}) : super(key: key);

  @override
  _OlvidarContraContraScreenState createState() =>
      _OlvidarContraContraScreenState();
}

class _OlvidarContraContraScreenState extends State<OlvidarContraContraScreen> {
  bool _isPasswordVisible = false;

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
                Navigator.pop(context);
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
                          "Por favor ingrese su nueva contraseña",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height:
                                300), // Espacio adicional antes del campo de correo electrónico
                        // Campo para ingresar el correo
                        TextField(
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.white,
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
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Crear nueva contraseña',
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
