import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_fin_de_curso/quiz/quiz_page.dart';

import 'auth_page.dart';
import 'pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Un StreamBuilder es un Widget que se usa para monitorear datos que cambian en tiempo real.
        //Está esperando un Stream que se llama 'FirebaseAuth.instance.authStateChanges()',
        //que devuelve un Stream de los cambios de estado de autenticación de Firebase.
        //El argumento 'builder' del StreamBuilder es una función que toma un contexto (context) y un snapshot (snapshot) como argumentos.
        //El snapshot contiene los datos que se reciben del Stream y el contexto le permite al StreamBuilder renderizar los Widgets correctos.
        //El StreamBuilder renderiza un Widget dentro del cuerpo de Scaffold que se especifica en el código.
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      //builder necesita context del widget y el snapshot es el parametro que tiene StreamBuilder que es User
      //que es una clase que trae FireBase y ejecuta en función de si existe o no
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return QuizPage();
        } else {
          return AuthPage();
        }
      },
    ));
  }
}
