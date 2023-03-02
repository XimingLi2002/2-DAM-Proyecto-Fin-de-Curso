// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_fin_de_curso/util.dart';

import '../../reusable_widget.dart';

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

//Future -> permite crear operaciones de larga duración sin bloquear el hilo principal y el uso de operaciones asincrónicas
  Future passwordReset() async {
    try {
      //await -> espera hasta que termine la tarea
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

      //captura el error en caso de que el correo electrónico sea inválido.
    } on FirebaseAuthException catch (e) {
      //cuando aparece un error en flutter con catch nos describe directamente el error,
      //algunos de los mensajes que nos devuelve en este caso sería:
      //The email address is badly formatted.
      //There is no user record corresponding to this identifier. The user may have been deleted.

      showAlertMessage(context, e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#9dcead'),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex('#36b569'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Image(
              image: AssetImage('assets/img/logo.png'),
              fit: BoxFit.fitWidth,
              width: 175,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Please enter your email address below. You will recieve a link to create a new password via email.',
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
                    //enabledBorder -> el borde que se muestra por defecto
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white)),
                    //focusBorder -> El borde que se muestra al estar focuseado
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: HexColor.fromHex("#be76a6"))),
                    hintText: 'Email',
                    //Color del background del TextField
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            //Button
            MaterialButton(
              onPressed: passwordReset,
              color: HexColor.fromHex('#1d8247'),
              child: Text('Reset Password'),
            )
          ],
        ),
      ),
    );
  }
}
