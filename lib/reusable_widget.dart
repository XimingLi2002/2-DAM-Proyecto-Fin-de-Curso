import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(prefixIcon: Icon(icon, color: Colors.white70)),
  );
}

Future showCircularProgressIndicator(BuildContext context){
  return showDialog(
    barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
}

Future showAlertMessage(BuildContext context, String text) {
  return showDialog(
      //barrierDismissible -> Por defecto se puede cerrar el cuadro de error pulsando cualquier parte fuera de esta en la pantalla
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error!',
              style: GoogleFonts.robotoSerif(
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.red[800]))),
          content: Text(text),
          actions: [
            //MaterialButton -> tipo de botón indispensable para el desarrollo Android
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      });
}
