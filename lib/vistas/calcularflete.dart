import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pdfWidget;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:proyectotrailer/Assistants/assistantMethods.dart';
import 'package:proyectotrailer/modelos/LugaresPredicciones.dart';
import 'package:proyectotrailer/modelos/appDaata.dart';
import 'package:proyectotrailer/Assistants/assistantMethods.dart';
import 'package:proyectotrailer/modelos/direcciondetalles.dart';
import 'package:http/http.dart' as http;
import 'package:proyectotrailer/services/auth_services.dart';
import 'package:proyectotrailer/services/flete_services.dart';
import 'package:proyectotrailer/services/globals.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Flete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FleteCalculator(),
    );
  }
}

class FleteCalculator extends StatefulWidget {
  @override
  _FleteCalculatorState createState() => _FleteCalculatorState();
}

class _FleteCalculatorState extends State<FleteCalculator> {
  TextEditingController PuntoOrigenTextEditingController =
      TextEditingController();
  TextEditingController PuntoDestinoTextEditingController =
      TextEditingController();
  List<PlacePredictions> listaPrediccionesLugares = [];

  double peso = 0.0;
  double gasolina = 0.0;
  double peaje = 0.0;
  double carga = 0.0;
  double comida = 0.0;
  double federales = 0.0;

  String _ciudadDestino = "";
  int _Kilometros = 0;
  String _ciudadOrigen = "";
  String _fechaSalida = "";
  String _fechaLlegada = "";

  double _gasolina = 0.0;
  double _peaje = 0.0;
  double _carga = 0.0;
  double _comida = 0.0;
  double _federales = 0.0;
  double _total = 0.0;

  double resultado = 0.0;
  double sumaFlete = 0.0;
  int distanciaCalculada = 0; // Variable para almacenar la distancia calculada

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickupLocation.placeName ?? "";
    PuntoOrigenTextEditingController.text = placeAddress;

    String placeAddress2 =
        Provider.of<AppData>(context).dropOffLocation.placeName ?? "";
    PuntoDestinoTextEditingController.text = placeAddress2;
    // Obtén la posición inicial y final desde AppData
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickupLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    AssitantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng)
        .then((details) {
      if (details != null && mounted) {
        setState(() {
          distanciaCalculada = AssitantMethods.calcularDistancia(details);
        });
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('TruckApp'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Container(
              height: MediaQuery.of(context).size.height, // Set a fixed height
              child: Stack(children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 251, 251, 251),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue,
                                blurRadius: 18,
                                spreadRadius: 0.5,
                                offset: Offset(0.6, 0.6),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Calcular Flete",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.amber.shade400,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "images/Km.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text(
                                          "Distancia:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "$distanciaCalculada km",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top:
                                          80.0), // Ajusta el espaciado según sea necesario
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextField(
                                          onChanged: (value) {
                                            _gasolina =
                                                double.tryParse(value) ?? 0.0;
                                          },
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                            labelText: 'Gasolina ',
                                            prefixText:
                                                '\$ ', // Aquí puedes ajustar el símbolo de la moneda
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        TextField(
                                          onChanged: (value) {
                                            _peaje =
                                                double.tryParse(value) ?? 0.0;
                                          },
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                            labelText: 'Peaje',
                                            prefixText: '\$ ',
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        TextField(
                                          onChanged: (value) {
                                            _carga =
                                                double.tryParse(value) ?? 0.0;
                                          },
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                            labelText: 'Carga',
                                            prefixText: '\Kg ',
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        TextField(
                                          onChanged: (value) {
                                            _comida =
                                                double.tryParse(value) ?? 0.0;
                                          },
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                            labelText: 'Comida',
                                            prefixText: '\$ ',
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        TextField(
                                          onChanged: (value) {
                                            _federales =
                                                double.tryParse(value) ?? 0.0;
                                          },
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                            labelText: 'Federales',
                                            prefixText: '\$ ',
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                calcularFlete();
                                              },
                                              child: Text('Calcular Flete'),
                                            ),
                                            // Agrega espacio vertical entre los botones
                                            ElevatedButton(
                                              onPressed: () {
                                                AceptarFlete();
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.deepOrange),
                                              ),
                                              child: Text('Aceptar Flete'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                _crearpdf(
                                                    context,
                                                    _Kilometros.toString(),
                                                    _ciudadOrigen,
                                                    _ciudadDestino,
                                                    _fechaSalida,
                                                    _fechaLlegada,
                                                    _gasolina.toString(),
                                                    _peaje.toString(),
                                                    _carga.toString(),
                                                    _comida.toString(),
                                                    _federales.toString(),
                                                    _total.toString());
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.deepOrange),
                                              ),
                                              child: Text('Generar PDF'),
                                            ),
                                            SizedBox(height: 16.0),
                                            Text('Total: $resultado'),
                                          ],
                                        ),
                                      ]),
                                )
                              ],
                            ),
                          ),
                        )))
              ]),
            ))));
  }

  // Guarda el PDF o compártelo según tus necesidades

  void calcularFlete() async {
    // Realiza la suma de los valores almacenados
    sumaFlete = _gasolina + _peaje + _comida + _federales;

    // Actualiza el estado con el resultado
    setState(() {
      resultado = sumaFlete;
    });
  }

  AceptarFlete() async {
    EasyLoading.show(); // Mostrar el indicador de carga

    try {
      _Kilometros = distanciaCalculada;
      _ciudadOrigen = PuntoOrigenTextEditingController.text;
      _ciudadDestino = PuntoDestinoTextEditingController.text;
      _fechaSalida = "2023-12-03 19:58:11";
      _fechaLlegada = "2023-12-03 22:50:11";
      _gasolina = _gasolina.toDouble();
      _peaje = _peaje.toDouble();
      _carga = _carga.toDouble();
      _comida = _comida.toDouble();
      _federales = _federales.toDouble();
      _total = resultado.toDouble();

      http.Response response = await FleteServices.crearViaje(
        _Kilometros,
        _ciudadOrigen,
        _ciudadDestino,
        _fechaSalida,
        _fechaLlegada,
        _gasolina,
        _peaje,
        _carga,
        _comida,
        _federales,
        _total,
      );

      Map responseMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await Future.delayed(
            Duration(seconds: 1)); // Agrega un retraso de 1 segundo

        // Si la cuenta se ha creado con éxito
        EasyLoading.dismiss();

        EasyLoading.showSuccess('Flete aceptado con éxito');
      } else {
        EasyLoading.dismiss();
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } catch (e) {
      EasyLoading.dismiss();
      errorSnackBar(context, 'Error en la solicitud');
    }
  }

  _crearpdf(
    BuildContext context,
    _Kilometros,
    _ciudadOrigen,
    _ciudadDestino,
    _fechaSalida,
    _fechaLlegada,
    _gasolina,
    _peaje,
    _carga,
    _comida,
    _federales,
    _total,
  ) async {
    final pdfLib.Document pdf = pdfLib.Document(
        deflate: zlib.encode,
        theme: pdfLib.ThemeData.withFont(
            base: pdfLib.Font.ttf(
                await rootBundle.load('assets/fonts/Arial.ttf'))));
    final Uint8List imageBytes =
        (await rootBundle.load('images/trucking.jpg')).buffer.asUint8List();
    final pdfWidgets.Image image = pdfWidgets.Image(
        pdfLib.MemoryImage(imageBytes),
        width: 400,
        height: 400);

    pdf.addPage(
      pdfLib.MultiPage(
        build: (context) => [
          pdfLib.Header(text: 'Informe del Flete'),
          image,
          pdfLib.TableHelper.fromTextArray(
            data: <List<String>>[
              <String>[
                'kilometros',
                'Origen',
                'destino',
                'salida',
                'llegada',
                'gasolina',
                'peaje',
                'carga',
                'comida',
                'federales',
                'total'
              ],
              [
                _Kilometros,
                _ciudadOrigen,
                _ciudadDestino,
                _fechaSalida,
                _fechaLlegada,
                _gasolina,
                _peaje,
                _carga,
                _comida,
                _federales,
                _total,
              ]
            ],
            columnWidths: {
              0: pdfLib.FlexColumnWidth(9),
              1: pdfLib.FlexColumnWidth(7),
              2: pdfLib.FlexColumnWidth(7),
              3: pdfLib.FlexColumnWidth(7),
              4: pdfLib.FlexColumnWidth(5),
              5: pdfLib.FlexColumnWidth(5),
              6: pdfLib.FlexColumnWidth(5),
              7: pdfLib.FlexColumnWidth(5),
              8: pdfLib.FlexColumnWidth(5),
              9: pdfLib.FlexColumnWidth(5),
              10: pdfLib.FlexColumnWidth(5),
            },
            cellStyle: pdfLib.TextStyle(color: PdfColors.blue800 // Color azul
                ),
          ),
          pdfLib.SizedBox(height: 320),
          pdfLib.Header(text: ''),
        ],
      ),
    );

    final Uint8List bytes = await pdf.save();

    try {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/Registro del Flete.pdf';

      final File file = File(path);
      await file.writeAsBytes(
          bytes); // Espera a que se completen los bytes antes de escribir en el archivo

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PDFScreen(path)),
      );
    } catch (e) {
      print('Error al escribir en el archivo: $e');
    }
  }
}

class PDFScreen extends StatelessWidget {
  PDFScreen(this.pathPDF);

  final String pathPDF;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro del Flete"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareFile(context, pathPDF);
            },
          )
        ],
      ),
      body: SfPdfViewer.file(
        File(pathPDF),
      ),
    );
  }

  void _shareFile(BuildContext context, String filePath) {
    Share.shareFiles([filePath], text: 'Compartir PDF');
  }

  void compartirPDF() {
    String message = "Comparte este flete";
    Share.share(message);
  }
}
