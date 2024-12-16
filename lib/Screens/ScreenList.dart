import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Screenlist extends StatefulWidget {
  const Screenlist({super.key});

  @override
  _ScreenlistState createState() => _ScreenlistState();
}

class _ScreenlistState extends State<Screenlist> {
  late FirebaseDatabase _database;
  late DatabaseReference _dataRef;
  List<Map<String, dynamic>> _dataList = [];

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  // Inicializar Firebase correctamente
  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(); // Inicializamos Firebase
    _database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),  // Obtén la instancia de FirebaseApp
      databaseURL: 'https://fireflutter-f7c4a-default-rtdb.firebaseio.com',  // Tu URL personalizada
    );
    _dataRef = _database.ref('bills');  // Cambia 'bills' al nodo correcto
    _getData();
  }

  // Obtener los datos de Firebase
  Future<void> _getData() async {
    DatabaseEvent event = await _dataRef.once();
    var snapshot = event.snapshot;

    if (snapshot.exists) {
      var data = snapshot.value as Map;
      List<Map<String, dynamic>> billsList = [];
      
      data.forEach((key, value) {
        billsList.add({
          'titulo': value['titulo'],
          'descripcion': value['Descripcion'],
          'precio': value['precio'],
          'timestamp': value['timestamp']
        });
      });

      setState(() {
        _dataList = billsList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista desde Firebase'),
      ),
      body: _dataList.isEmpty
          ? Center(child: CircularProgressIndicator()) // Indicador de carga
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                var bill = _dataList[index]; // Accedemos a los datos del bill
                return ListTile(
                  title: Text(bill['titulo'] ?? 'Sin Título'),
                  subtitle: Text('Descripción: ${bill['descripcion']}\nPrecio: ${bill['precio']}\nTimestamp: ${bill['timestamp']}'),
                );
              },
            ),
    );
  }
}
