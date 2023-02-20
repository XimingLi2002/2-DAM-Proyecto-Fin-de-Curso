// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_fin_de_curso/auth/pages/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  //VoidCallBack es una función que no devuelve nada y normalmente es usado para la comunicación entre widgets
  //https://www.youtube.com/watch?v=fWlPwj1Pp7U&ab_channel=developer.school
  final VoidCallback showRegisterPage;

  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    //loading
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    //pop the loading circle
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold es como un widget principal es decir la pantalla completa
    return Scaffold(
        backgroundColor: Colors.red.shade200,
        body: SafeArea(
          child: Center(
            //Evita que el teclado se sobreponga sobre los componentes
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Se puede ver el tamaño de la imagen si le pontemos lo almacenamos en un Container y le damos un color (es decir el background)
                  Image(image: AssetImage('assets/logo.png'), fit: BoxFit.fitWidth, width: 240, filterQuality: FilterQuality.high,),
                  SizedBox(
                    height: 25,
                  ),

                  //Hello Again!
                  Text(
                    'Hello Again!',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 52,
                    ),
                    //TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
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
                  SizedBox(
                    height: 10,
                  ),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          //enabledBorder -> The border to display when is enabled and is not showing an error.
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          //focusBorder -> The border to display when has the focus and is not showing an error.
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          hintText: 'Password',
                          //Color del background del TextField
                          fillColor: Colors.grey[200],
                          filled: true),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Forget password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //Navigator.push() es un método en Flutter que se usa para navegar entre vistas usando una transición animada. 
                            //Este método toma un contexto y una ruta como parámetros y agrega la ruta a la pila de navegación, 
                            //lo que le permite al usuario regresar a la vista anterior. 
                            //Esta ruta puede ser una instancia de una clase de componente decorada con @PageRoute 
                            //o una instancia de MaterialPageRoute, que proporciona una forma simple de navegar entre vistas con transiciones 
                            //animadas basadas en la plataforma.
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ForgotPasswordPage();
                            }));
                          },
                          child: Text('Forgot password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //GestureDetector -> used to detect the user's actions on the application.
                    //It is a non-visual widget that detects events on its child widgets.
                    //onTap, onDoubleTap, onLongPress...
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          ' Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
