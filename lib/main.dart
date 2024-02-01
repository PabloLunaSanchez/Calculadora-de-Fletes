import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proyectotrailer/Assistants/assistantMethods.dart';
import 'package:proyectotrailer/modelos/appDaata.dart';
import 'package:proyectotrailer/vistas/login_vista/login/login.dart';
import 'package:proyectotrailer/vistas/mapa.dart';
import 'package:proyectotrailer/vistas/olvidarcontrase%C3%B1aemail.dart';
import 'package:proyectotrailer/vistas/registro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: "Trailer",
        theme: ThemeData(
          fontFamily: "Brand Bold",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RegistroPage(),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
