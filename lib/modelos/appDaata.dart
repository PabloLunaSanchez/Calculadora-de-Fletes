import 'package:flutter/material.dart';
import 'package:proyectotrailer/modelos/direcciones.dart';

class AppData extends ChangeNotifier {
  late Address pickupLocation, dropOffLocation;

  AppData() {
    // Inicializa la variable pickupLocation aquí
    pickupLocation = Address(
      placeFormattedAddress: '', // Inicializa con valores adecuados
      placeName: '',
      placeId: '',
      latitude: 0.0,
      longitude: 0.0,
    );
    dropOffLocation = Address(
      placeFormattedAddress: '', // Inicializa con valores adecuados
      placeName: '',
      placeId: '',
      latitude: 0.0,
      longitude: 0.0,
    );
  }

  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickupLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}
