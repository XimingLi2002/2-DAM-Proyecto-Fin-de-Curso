// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

//Declarar funciones como Future en Flutter es útil para varias razones. Primero, permite al programador crear operaciones de larga duración sin bloquear el hilo principal. Esto significa que los usuarios no tendrán que esperar mucho tiempo para que la aplicación responda. Además, también es útil para operaciones asincrónicas como la realización de peticiones a servicios web, ya que los Future permiten a los programadores crear flujos de trabajo claros y sencillos para manejar la lógica de la aplicación.
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! Check your email'),
            );
          });
      
      //Por si el correo introducido no existe
    } on FirebaseAuthException catch (e) {
      // print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade200,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Enter Your Email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          //email textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  //enabledBorder -> The border to display when is enabled and is not showing an error.
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white)),
                  //focusBorder -> The border to display when has the focus and is not showing an error.
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  hintText: 'Email',
                  //Color del background del TextField
                  fillColor: Colors.grey[200],
                  filled: true),
            ),
          ),

          //Button
          MaterialButton(
            onPressed: passwordReset,
            color: Colors.red.shade200,
            child: Text('Reset Password'),
          )
        ],
      ),
    );
  }
}
