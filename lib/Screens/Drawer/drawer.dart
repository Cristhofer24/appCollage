
import 'package:app_collage/Screens/ScreenAdd.dart';
import 'package:app_collage/Screens/ScreenList.dart';
import 'package:app_collage/Screens/screenLogin.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(
        children: [
          ListTile(
            title: Text("Ver Lista de Gastos"),
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=> Screenlist())),
          ),
          ListTile(
            title: Text("Agregar Lista"),
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=> ScreenAdd(isEditMode: false,))),
          ),
             ListTile(
            title: Text("Salir"),
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=> Screenlogin())),
          ),
        
        
        ]
      ),
    );
  }
}