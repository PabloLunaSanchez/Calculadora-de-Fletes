import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:proyectotrailer/Assistants/assistantMethods.dart';
import 'package:proyectotrailer/main.dart';
import 'package:proyectotrailer/modelos/appDaata.dart';
import 'package:proyectotrailer/vistas/calcularflete.dart';
import 'package:proyectotrailer/vistas/historial%20de%20viajes.dart';
import 'package:proyectotrailer/vistas/registro.dart';
import 'package:proyectotrailer/vistas/search.dart';
import 'package:proyectotrailer/widgets/divider.dart';
import 'package:http/http.dart' as http;
import '../services/usuario.dart';
import '../services/usuariomanager.dart';

class MapPageScreen extends StatefulWidget {
  const MapPageScreen({Key? key}) : super(key: key);

  @override
  _MapPageScreenState createState() => _MapPageScreenState();
}

class _MapPageScreenState extends State<MapPageScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  late GoogleMapController newGoogleMapController;
  LatLng defaultOriginLatLng = LatLng(
      37.7749, -122.4194); // Coordenadas de tu punto de origen predeterminado

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  String address = "";

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  late GoogleMapController mapController;
  int distanciaCalculada = 0;

  Usuario? usuario;

  @override
  void initState() {
    super.initState();
    _cargarUsuario();
    locatePosition();
  }

  Future<void> _cargarUsuario() async {
    Usuario? usuario = await UsuarioManager.obtenerUsuario();
    setState(() {
      this.usuario = usuario;
    });
  }

  void locatePosition() async {
    // Usar las coordenadas del punto de origen predeterminado

    // Puedes asignar el punto de origen predeterminado a la variable currentPosition si es necesario
    Position currentPosition = Position(
        latitude: 22.2160,
        longitude: -97.8550,
        timestamp: DateTime.now(),
        accuracy: 10.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        headingAccuracy: 0.0);

    address =
        await AssitantMethods.searchCoordinateAddress(currentPosition, context);
    print("Esta es tu direccion :: " + address);
  }

  static final CameraPosition _kgooglePlex =
      CameraPosition(target: LatLng(22.2160, -97.8550), zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 120, 193),
        title: Text("Mapa Nacional"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(usuario?.nombre ?? ""),
              accountEmail: Text(usuario?.correo ?? ""),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(child: Image.asset('images/admin.png')),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage('images/fondoanavbar.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Editar perfil'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Historial de viajes'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaginaHistorial(
                        title: '',
                      ),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificaciones'),
              onTap: () {
                // Implementa la acción deseada.
              },
            ),
            ListTile(
              leading: Icon(Icons.help_center),
              title: Text('Ayuda'),
              onTap: () {
                // Implementa la acción deseada.
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                // Implementa la acción deseada. Navigator.push(context,
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegistroPage()));
              },
            ),
          ],
        ),
      ),
      body: Stack(children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kgooglePlex,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          polylines: polylineSet,
          markers: markersSet,
          circles: circlesSet,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

            setState(() {
              bottomPaddingOfMap = 300.0;
            });
            locatePosition();
          },
        ),
        Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
                height: 300.0,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 30, 120, 193),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "Bienvenido",
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                        Text(
                          "¿Cual es el origen y destino del flete?",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Brand-Bold",
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              "Distancia: ",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "$distanciaCalculada",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " km",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                            if (res == "obtainDirection") {
                              await getPlaceDirection();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 8, 68, 118),
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 16.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(0.7, 0.7),
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Busque un destino",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          children: [
                            Image.asset(
                              "images/origen.png",
                              width: 34,
                              height: 34,
                            ),
                            SizedBox(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<AppData>(context)
                                            .pickupLocation !=
                                        null
                                    ? Provider.of<AppData>(context)
                                        .pickupLocation
                                        .placeName
                                    : "Add Home"),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "Punto de origen",
                                  style: TextStyle(
                                      color: Colors.grey[200], fontSize: 12.0),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10.0),
                        DividerWidget(),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Image.asset(
                              "images/destino.png",
                              width: 34,
                              height: 34,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Provider.of<AppData>(context)
                                                .pickupLocation !=
                                            null
                                        ? Provider.of<AppData>(context)
                                            .dropOffLocation
                                            .placeName
                                        : "Punto de origen",
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "Punto destino",
                                    style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: 12.0),
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FleteCalculator()));
                              },
                              child: Text("Calcular Flete"),
                            ),
                          ],
                        ),
                      ]),
                  /* Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            height: 260.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 17.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.tealAccent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/car4.png",
                            height: 70.0,
                            width: 80.0,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Car",
                                style: TextStyle(
                                    fontSize: 18.0, fontFamily: "Brand-Bold"),
                              ),
                              Text(
                                "10km",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.moneyCheckDollar,
                          size: 18.0,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text("Cash"),
                        SizedBox(
                          width: 6.0,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black54,
                          size: 16.0,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () {
                          // Coloca aquí la acción que deseas que se ejecute al presionar el botón.
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Request",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(
                                FontAwesomeIcons.taxi,
                                color: Colors.white,
                                size: 18.0,
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ) */
                )))
      ]),
    );
  }

  /*  Future<BitmapDescriptor> createCarBitmapDescriptor() async {
    final Uint8List carIconData =
        await (await rootBundle.load("images/car3.png")).buffer.asUint8List();
    return BitmapDescriptor.fromBytes(carIconData);
  }
 */
  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickupLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context: context,
      barrierDismissible:
          false, // Evita que el usuario cierre el diálogo tocando fuera de él.
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(), // Agrega el círculo de progreso.
                SizedBox(height: 10), // Espacio entre el círculo y el mensaje.
                Text(
                  "Cargando, por favor espere...", // Mensaje de espera.
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );

    var details = await AssitantMethods.obtainPlaceDirectionDetails(
      pickUpLatLng,
      dropOffLatLng,
    );

    Navigator.pop(context); // Cierra el diálogo de progreso.

    print("This is encoded Points ::");
    print(details?.encodedPoints);

    // Llama a distancia con details y utiliza el resultado
    distanciaCalculada = AssitantMethods.calcularDistancia(details!);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details!.encodedPoints);

    pLineCoordinates.clear();

    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polylineSet.clear;
    setState(() {
      Polyline polyline = Polyline(
          color: Colors.pink,
          polylineId: PolylineId("PolylineID"),
          jointType: JointType.round,
          points: pLineCoordinates,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      polylineSet.add(polyline);
    });
    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }
    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow:
            InfoWindow(title: initialPos.placeName, snippet: "Mi locacion"),
        position: pickUpLatLng,
        markerId: MarkerId("pickupId"));

    Marker dropOffLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: finalPos.placeName, snippet: "Destino"),
        position: dropOffLatLng,
        markerId: MarkerId("dropOffId"));

    //final BitmapDescriptor carIcon = await createCarBitmapDescriptor();

    /*  Marker carMarker = Marker(
      markerId: MarkerId("car"),
      position: pickUpLatLng, // La posición inicial del carro (punto de origen)
      icon: carIcon, // Ruta de la imagen del carro
      anchor:
          Offset(0.5, 0.5), // Establece el anclaje en el centro de la imagen
    );

    void moveCarMarker() {
      // Simula el movimiento del carro desde pickUpLatLng a dropOffLatLng
      for (double fraction = 0; fraction <= 1; fraction += 0.01) {
        LatLng animatedCarPosition = LatLng(
          pickUpLatLng.latitude +
              fraction * (dropOffLatLng.latitude - pickUpLatLng.latitude),
          pickUpLatLng.longitude +
              fraction * (dropOffLatLng.longitude - pickUpLatLng.longitude),
        );

        setState(() {
          carMarker = carMarker.copyWith(positionParam: animatedCarPosition);
        });

        // Espera un breve período de tiempo entre actualizaciones
        Future.delayed(Duration(milliseconds: 100));
      }
    } */

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
      /*   markersSet.add(carMarker);
      moveCarMarker(); */
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpId"),
    );
    Circle dropOffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.red,
      circleId: CircleId("pickUpId"),
    );
    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
  }
}
