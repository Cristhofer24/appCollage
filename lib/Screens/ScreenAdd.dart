import 'package:app_collage/Screens/Drawer/drawer.dart';
import 'package:app_collage/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ScreenAdd extends StatefulWidget {
  final bool isEditMode;
  final String? billKey;
  final String? titulo;
  final String? descripcion;
  final String? precio;

  const ScreenAdd({
    super.key,
    required this.isEditMode,
    this.billKey,
    this.titulo,
    this.descripcion,
    this.precio,
  });

  @override
  _ScreenAddState createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode) {
      // Si es el modo edición, cargamos los datos del bill
      title.text = widget.titulo ?? '';
      description.text = widget.descripcion ?? '';
      price.text = widget.precio ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Editar Gasto' : 'Agregar Gasto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleInput(),
            SizedBox(height: 20),
            descriptionInput(),
            SizedBox(height: 20),
            priceInput(),
            SizedBox(height: 20),
            btnSave(context),
          ],
        ),
      ),
    );
          

  }

  Widget titleInput() {
    return TextField(
      controller: title,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Ingrese el Nombre de su gasto"),
      ),
    );
  }

  Widget descriptionInput() {
    return TextField(
      controller: description,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Ingrese la Descripcion"),
      ),
    );
  }

  Widget priceInput() {
    return TextField(
      controller: price,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Ingrese el Precio"),
      ),
    );
  }

  Widget btnSave(BuildContext context) {
    return ElevatedButton(
      onPressed: () => save(),
      child: Text(widget.isEditMode ? 'Guardar Cambios' : 'Guardar'),
    );
  }

  Future<void> save() async {
    try {
      FirebaseApp app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final DatabaseReference ref = FirebaseDatabase.instanceFor(
        app: app,
        databaseURL: 'https://fireflutter-f7c4a-default-rtdb.firebaseio.com',
      ).ref("bills");

      if (widget.isEditMode) {
        // Actualizamos el ítem si estamos en modo edición
        await ref.child(widget.billKey!).update({
          "titulo": title.text,
          "Descripcion": description.text,
          "precio": price.text,
          "timestamp": DateTime.now().toString(),
        });
      } else {
        // Creamos un nuevo ítem si no estamos en modo edición
        await ref.push().set({
          "titulo": title.text,
          "Descripcion": description.text,
          "precio": price.text,
          "timestamp": DateTime.now().toString(),
        });
      }

      print("Datos guardados correctamente.");
      Navigator.pop(context); // Volver a la pantalla anterior después de guardar
    } catch (e) {
      print("Error al guardar los datos: $e");
    }
  }
}
