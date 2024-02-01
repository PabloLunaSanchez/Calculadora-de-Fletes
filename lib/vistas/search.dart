import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectotrailer/Assistants/requestassistant.dart';
import 'package:proyectotrailer/modelos/LugaresPredicciones.dart';
import 'package:proyectotrailer/modelos/appDaata.dart';
import 'package:proyectotrailer/modelos/direcciones.dart';
import 'package:proyectotrailer/widgets/divider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController PuntoOrigenTextEditingController =
      TextEditingController();
  TextEditingController PuntoDestinoTextEditingController =
      TextEditingController();
  List<PlacePredictions> listaPrediccionesLugares = [];

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickupLocation.placeName ?? "";
    PuntoOrigenTextEditingController.text = placeAddress;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 215.0,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 11, 99, 165),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7))
              ]),
          child: Padding(
            padding: EdgeInsets.only(
                left: 25.0, top: 20.0, right: 25.0, bottom: 20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    Center(
                      child: Text(
                        "Punto de Patida",
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: "Brand.Bold"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_searching,
                    ),
                    SizedBox(height: 18.0),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                controller: PuntoOrigenTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Punto de origen",
                                  fillColor: Colors.grey[400],
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 11.0, top: 8.0, bottom: 8.0),
                                ),
                              ),
                            )))
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                    ),
                    SizedBox(height: 18.0),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                onChanged: (val) {
                                  encontrarLugar(val);
                                },
                                controller: PuntoDestinoTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Destino",
                                  fillColor: Colors.grey[400],
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 11.0, top: 8.0, bottom: 8.0),
                                ),
                              ),
                            )))
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        (listaPrediccionesLugares.length > 0)
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListView.separated(
                  padding: EdgeInsets.all(0.0),
                  itemBuilder: (context, index) {
                    return PrediccionesTitulo(
                        key: GlobalKey(),
                        placePredictions: listaPrediccionesLugares[index]);
                  },
                  separatorBuilder: (BuildContextcontext, int index) =>
                      DividerWidget(),
                  itemCount: listaPrediccionesLugares.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                ),
              )
            : Container(),
      ]),
    ));
  }

  void encontrarLugar(String placeName) async {
    if (placeName.length >= 1) {
      String autocompletadourl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&types=geocode&key=AIzaSyDipSVHu-8eQHpsZgNy6g1w_gxMJonEyFk&components=country:mx";

      var res = await RequestAssistant.getRequest(Uri.parse(autocompletadourl));

      if (res == "failed") {
        return;
      }
      if (res["status"] == "OK") {
        var predicciones = res["predictions"];

        var listaLugares = (predicciones as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        setState(() {
          listaPrediccionesLugares = listaLugares;
        });
      }
    }
  }
}

class PrediccionesTitulo extends StatelessWidget {
  final PlacePredictions placePredictions;

  PrediccionesTitulo({required Key key, required this.placePredictions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0.0),
          backgroundColor:
              Colors.blue[233] // Ajusta el relleno según tus necesidades
          ),
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: 14.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        placePredictions.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: const Color.fromARGB(255, 31, 30, 30)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyDipSVHu-8eQHpsZgNy6g1w_gxMJonEyFk";

    var res = await RequestAssistant.getRequest(Uri.parse(placeDetailsUrl));

    Navigator.pop(context);

    if (res == "failed") {
      return;
    }
    if (res["status"] == "OK") {
      Address address = Address(
          placeFormattedAddress: '',
          placeName: '',
          placeId: '',
          latitude: 0.0,
          longitude: 0.0);
      address.placeName = res["result"]["name"];
      address.placeId = placeId;

      if (res["result"]["geometry"]["location"] != null) {
        address.latitude = res["result"]["geometry"]["location"]["lat"];
        address.longitude = res["result"]["geometry"]["location"]["lng"];
      } else {
        address.latitude = 0.0; // Asigna un valor predeterminado si es null
        address.longitude = 0.0; // Asigna un valor predeterminado si es null
      }

      Provider.of<AppData>(context, listen: false)
          .updateDropOffLocationAddress(address);
      print("Este es tu destino ::");
      print(address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
