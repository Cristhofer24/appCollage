import 'package:app_collage/Screens/screenLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Screenregister extends StatelessWidget {
  const Screenregister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0), // Add some padding around the content
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
          children: [
            input_email(),
            SizedBox(height: 20), // Add some spacing between input fields and button
            input_password(),
            SizedBox(height: 20), // Add some spacing between password and button
            btn_Register(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: navigateLogin(context),
            )
          ],
        ),
    )

    );
  }
}

//Componentes para el aplicativo Collage 


TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
Widget input_email(){
return TextField(
  controller: email,
     decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Ingrese su Correo Electronico',
    ),
);
}
Widget input_password(){
return TextField(
  controller: password,
     decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Ingrese su contraseña',
    ),
);
}
Widget btn_Register(context){
  return FilledButton(onPressed: ()=> register(email.text, password.text,context),

   child: Text("Registrate", style: TextStyle(fontSize: 18),),
   style: ButtonStyle( backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 18, 99, 220)),

   padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(horizontal: 80, vertical: 15)),
    ),
   
   );
}
Widget navigateLogin(context){
  return FilledButton(onPressed: ()=> {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screenlogin()))
  },

   child: Text("Iniciar Sesión", style: TextStyle(fontSize: 18),),
   style: ButtonStyle( backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 18, 99, 220)),

   padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(horizontal: 80, vertical: 15)),
    ),
   
   );
}
void register(email, password, context) async {
try {
  // ignore: unused_local_variable
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}

}


