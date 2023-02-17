import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_fin_de_curso/login_page.dart';

import 'home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //StreamBuilder -> se ejecutara cada vez que ocurre lo que se indica en 'stream:' y ejecutara el builder
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      //builder necesita context del widget y el snapshot es el parametro que tiene StreamBuilder que es User
      //que es una clase que trae FireBase y ejecuta en función de si existe o no
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    ));
  }
}
