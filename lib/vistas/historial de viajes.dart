import 'package:flutter/material.dart';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Historial',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      useMaterial3: true,
    ),
    home: const PaginaHistorial(title: 'Historial de Viajes'),
  );
}

class PaginaHistorial extends StatefulWidget {
  const PaginaHistorial({super.key, required this.title});
  final String title;

  @override
  State<PaginaHistorial> createState() => _PaginaHistorialState();
}

class _PaginaHistorialState extends State<PaginaHistorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF83C6f6),
      appBar: AppBar(
        title: Text('Historial de Viajes'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              _cardHistorial(),
              _cardHistorial2(),
              _cardHistorial3(),
              _cardHistorial4(),
              _cardHistorial5(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _cardHistorial() {
  return Card(
    elevation: 5,
    color: Color(0xFFBDDFFA),
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Altamira - Monterrey',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Chofer: José López de Lara'),
          SizedBox(
            height: 5,
          ),
          Text('Salida:  16/Nov/2023 9:30 pm'),
          SizedBox(
            height: 5,
          ),
          Text('Llegada: 17/Nov/2023 4:40 am'),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Text('30 Toneladas'),
        ],
      ),
    ),
  );
}

Widget _cardHistorial2() {
  return Card(
    elevation: 5,
    color: Color(0xFFBDDFFA),
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Altamira - Cd Valles',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Chofer: José López de Lara'),
          SizedBox(
            height: 5,
          ),
          Text('Salida:  16/Nov/2023 9:30 pm'),
          SizedBox(
            height: 5,
          ),
          Text('Llegada: 17/Nov/2023 4:40 am'),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Text('30 Toneladas'),
        ],
      ),
    ),
  );
}

Widget _cardHistorial3() {
  return Card(
    elevation: 5,
    color: Color(0xFFBDDFFA),
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Altamira - Tampico',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Chofer: José López de Lara'),
          SizedBox(
            height: 5,
          ),
          Text('Salida:  16/Nov/2023 9:30 pm'),
          SizedBox(
            height: 5,
          ),
          Text('Llegada: 17/Nov/2023 4:40 am'),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Text('30 Toneladas'),
        ],
      ),
    ),
  );
}

Widget _cardHistorial4() {
  return Card(
    elevation: 5,
    color: Color(0xFFBDDFFA),
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Altamira - Ébano',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Chofer: José López de Lara'),
          SizedBox(
            height: 5,
          ),
          Text('Salida:  16/Nov/2023 9:30 pm'),
          SizedBox(
            height: 5,
          ),
          Text('Llegada: 17/Nov/2023 4:40 am'),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Text('30 Toneladas'),
        ],
      ),
    ),
  );
}

Widget _cardHistorial5() {
  return Card(
    elevation: 5,
    color: Color(0xFFBDDFFA),
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Altamira - Pánuco',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Chofer: José López de Lara'),
          SizedBox(
            height: 5,
          ),
          Text('Salida:  16/Nov/2023 9:30 pm'),
          SizedBox(
            height: 5,
          ),
          Text('Llegada: 17/Nov/2023 4:40 am'),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Text('30 Toneladas'),
        ],
      ),
    ),
  );
}
