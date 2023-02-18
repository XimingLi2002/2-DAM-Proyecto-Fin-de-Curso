import 'package:flutter/material.dart';
import 'package:proyecto_fin_de_curso/auth/pages/login_page.dart';
import 'package:proyecto_fin_de_curso/auth/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  //intially, show the login page
  bool showLoginPage = true;

  //El método toggleScreens () en el código anterior se usa para cambiar el estado de la variable showLoginPage entre true y false. 
  //Cuando la variable showLoginPage es true, se muestra la página de inicio de sesión. Cuando es false, se muestra la página de registro. 
  //toggleScreens () se llama desde la página de inicio de sesión y la página de registro para cambiar el estado de showLoginPage entre true y false.
  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(showRegisterPage: toggleScreens);
    }else{
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}