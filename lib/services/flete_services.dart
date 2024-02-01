import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyectotrailer/services/globals.dart';

class FleteServices {
  static Future<http.Response> crearViaje(
      int kilometros,
      String ciudadOrigen,
      String ciudadDestino,
      String fechaSalida,
      String fechaLlegada,
      double gasolina,
      double peaje,
      double carga,
      double comida,
      double federales,
      double total) async {
    Map data = {
      "Kilometros": kilometros,
      "ciudad_origen": ciudadOrigen,
      "ciudad_destino": ciudadDestino,
      "fecha_salida": fechaSalida,
      "fecha_llegada": fechaLlegada,
      "gasolina": gasolina,
      "peaje": peaje,
      "carga": carga,
      "comida": comida,
      "federales": federales,
      "total": total,
    };

    var body = json.encode(data);
    var url =
        Uri.parse(baseURL + 'auth/registerflete'); // Ajusta la URL según tu API
    http.Response response = await http.post(url, headers: headers, body: body);

    print(response.body);
    return response;
  }
}
