// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_fin_de_curso/auth/pages/forgot_password_page.dart';
import 'package:proyecto_fin_de_curso/util.dart';

import 'package:animate_icons/animate_icons.dart';

import '../../reusable_widget.dart';

class LoginPage extends StatefulWidget {
  //VoidCallBack -> función que no devuelve nada y normalmente es usado para la comunicación entre widgets
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

  var hidePassword = true;

  AnimateIconController controller = AnimateIconController();

  Future signIn() async {
    //loading
    showCircularProgressIndicator(context);

    try {
      //inicia sesión con la autentificación de Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      //una vez iniciado sesión con éxito cerrará el CircularProgressIndicator()
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      //si falla también deberá dejar de mostrar el CircularProgressIndicator()
      Navigator.of(context).pop();
      //muestra una alerta con el error
      showAlertMessage(context, e.message.toString());
    }
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
        backgroundColor: HexColor.fromHex('#9dcead'),
        body: SafeArea(
          child: Center(
            //Evita que el teclado se sobreponga sobre los componentes
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Se puede ver el tamaño de la imagen si se almacena en un Container y le damos un color (es decir el background)
                  Image(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.fitWidth,
                    width: 240,
                    filterQuality: FilterQuality.high,
                  ),
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
                        prefixIcon: Icon(Icons.lock,
                            color: HexColor.fromHex("#51a13d")),
                        //enabledBorder -> The border to display when is enabled and is not showing an error.
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: HexColor.fromHex("#ce9dbe"))),
                        //focusBorder -> The border to display when has the focus and is not showing an error.
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: HexColor.fromHex("#be76a6"))),
                        hintText: 'Email',
                        //Color del background del TextField
                        fillColor: Colors.white.withOpacity(0.3),
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      obscureText: hidePassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,
                            color: HexColor.fromHex("#51a13d")),
                        suffixIcon: AnimateIcons(
                          startIcon: Icons.visibility,
                          endIcon: Icons.visibility_off,
                          controller: controller,
                          size: 25.0,
                          onStartIconPress: () {
                            //setState -> notifica al framework que algo se ha cambiado para que ésta lo actualize
                            setState(() {
                              hidePassword = false;
                            });

                            return true;
                          },
                          onEndIconPress: () {
                            setState(() {
                              hidePassword = true;
                            });
                            return true;
                          },
                          duration: Duration(milliseconds: 500),
                          startIconColor: HexColor.fromHex("#51a13d").withOpacity(.25),
                          endIconColor: HexColor.fromHex("#51a13d").withOpacity(.75),
                          clockwise: false,
                        ),
                        //enabledBorder -> The border to display when is enabled and is not showing an error.
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: HexColor.fromHex("#ce9dbe"))),
                        //focusBorder -> The border to display when has the focus and is not showing an error.
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: HexColor.fromHex("#be76a6"))),
                        hintText: 'Password',
                        //Color del background del TextField
                        fillColor: Colors.white.withOpacity(0.3),
                        filled: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,
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
                                color: HexColor.fromHex('#b45698'),
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
                            color: HexColor.fromHex('#1d8247'),
                            borderRadius: BorderRadius.circular(30)),
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
                            color: HexColor.fromHex('#b45698'),
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
