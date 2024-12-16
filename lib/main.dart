import 'package:app_collage/Screens/ScreenAdd.dart';
import 'package:app_collage/Screens/ScreenList.dart';
import 'package:app_collage/Screens/screenLogin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home:ScreenAdd( isEditMode: false,),
      home: Screenlogin(),
    );
  }
}

class body extends StatelessWidget {
  const body ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenlogin(),
    );
  }
}