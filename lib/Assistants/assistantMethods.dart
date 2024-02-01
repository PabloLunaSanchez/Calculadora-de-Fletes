import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proyectotrailer/Assistants/requestassistant.dart';
import 'package:proyectotrailer/modelos/appDaata.dart';
import 'package:proyectotrailer/modelos/direcciondetalles.dart';
import 'package:proyectotrailer/modelos/direcciones.dart';

class AssitantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";

    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyDipSVHu-8eQHpsZgNy6g1w_gxMJonEyFk";

    try {
      var response = await RequestAssistant.getRequest(Uri.parse(url));

      if (response != "failed") {
        st1 = response["results"][0]["address_components"][0]["long_name"];
        st2 = response["results"][0]["address_components"][1]["long_name"];
        st3 = response["results"][0]["address_components"][5]["long_name"];
        st4 = response["results"][0]["address_components"][6]["long_name"];
        placeAddress = "$st1, $st2, $st3, $st4";

        // Crea una instancia de Address con argumentos
        Address userPickUpAddress = Address(
          placeFormattedAddress:
              "", // Proporciona un valor adecuado si es necesario
          placeName: placeAddress,
          placeId: "", // Proporciona un valor adecuado si es necesario
          latitude: position.latitude,
          longitude: position.longitude,
        );

        // Actualiza la dirección de recogida en AppData
        Provider.of<AppData>(context, listen: false)
            .updatePickUpLocationAddress(userPickUpAddress);
      }
    } catch (e) {
      print("Error al obtener la dirección: $e");
    }

    return placeAddress;
  }

  static Future<DirectionDetails?> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?destination=${finalPosition.latitude},${finalPosition.longitude}&origin=${initialPosition.latitude},${initialPosition.longitude}&key=AIzaSyDipSVHu-8eQHpsZgNy6g1w_gxMJonEyFk";

    try {
      var res = await RequestAssistant.getRequest(Uri.parse(directionUrl));

      if (res == "failed") {
        return null;
      }

      DirectionDetails directionDetails = DirectionDetails(
        distanceValue: 0,
        durationValue: 0,
        distanceText: '',
        durationText: '',
        encodedPoints: '',
      );

      if (res.containsKey("routes") &&
          res["routes"].isNotEmpty &&
          res["routes"][0].containsKey("overview_polyline") &&
          res["routes"][0]["overview_polyline"].containsKey("points") &&
          res["routes"][0]["legs"].isNotEmpty) {
        directionDetails.encodedPoints =
            res["routes"][0]["overview_polyline"]["points"];
        directionDetails.distanceText =
            res["routes"][0]["legs"][0]["distance"]["text"];
        directionDetails.distanceValue =
            res["routes"][0]["legs"][0]["distance"]["value"];
        directionDetails.durationText =
            res["routes"][0]["legs"][0]["duration"]["text"];
        directionDetails.durationValue =
            res["routes"][0]["legs"][0]["duration"]["value"];
      }

      return directionDetails;
    } catch (e) {
      print("Error al obtener detalles de la dirección: $e");
      return null;
    }
  }

  static int calcularDistancia(DirectionDetails directionDetails) {
    // Obtén la distancia en kilómetros desde DirectionDetails
    double distanciaEnKilometros = directionDetails.distanceValue / 1000.0;
    // Devuelve la distancia calculada
    return distanciaEnKilometros.round();
  }
}
