import 'package:app_collage/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ScreenAdd extends StatelessWidget {
  const ScreenAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}

TextEditingController title = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController price = TextEditingController();

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

Widget btnSave(context) {
  return ElevatedButton(
    onPressed: () => save(title.text, description.text, price.text),
    child: Text("Guardar"),
  );
}

Future<void> save(String titulo, String Descripcion, String precio) async {
  try {
    // Obtén la instancia de FirebaseApp
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  
    final DatabaseReference ref = FirebaseDatabase.instanceFor(
      app: app, 
      databaseURL: 'https://fireflutter-f7c4a-default-rtdb.firebaseio.com',
    ).ref("bills").push();

    // Guardamos los datos en la base de datos
    await ref.set({
      "titulo": titulo,
      "Descripcion": Descripcion,
      "precio": precio,
      "timestamp": DateTime.now().toString(), // Agregar un timestamp
    });

  
    print("Datos guardados correctamente en Firebase.");
  } catch (e) {
 
    print("Error al guardar los datos: $e");
  }
}
