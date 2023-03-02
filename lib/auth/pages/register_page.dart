// ignore_for_file: prefer_const_constructors

import 'package:animate_icons/animate_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_fin_de_curso/reusable_widget.dart';
import 'package:proyecto_fin_de_curso/util.dart';

class RegisterPage extends StatefulWidget {
  //VoidCallBack es una función que no devuelve nada y normalmente es usado para la comunicación entre widgets
  //https://www.youtube.com/watch?v=fWlPwj1Pp7U&ab_channel=developer.school

  //Esta clase toma una variable requerida llamada showLoginPage que es una función de devolución de llamada que se llama cuando se presiona el texto Login Now.
  //Esto permite que el usuario cambie entre la página de registro y la página de inicio de sesión al presionarlo.
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var hidePassword = true;
  var hideConfirmPassword = true;

  AnimateIconController controller = AnimateIconController();
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (isValidPassword() &&
        EmailValidator.isValidEmail(emailController.text.trim())) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

        showAlertMessage(context, e.message.toString());
      }

      //pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  //En Firebase la contraseña tiene que ser mínimo de 6 caracteres
  bool isValidPassword() {
    if (passwordController.text.trim() ==
            confirmPasswordController.text.trim() &&
        passwordController.text.trim().length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor.fromHex('#9dcead'),
        body: SafeArea(
          child: Center(
            //Evita que el teclado se sobreponga sobre los componentes
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Imagen
                  //Se puede ver el tamaño de la imagen si le pontemos lo almacenamos en un Container y le damos un color (es decir el background)
                  Image(
                    image: AssetImage('assets/img/logo.png'),
                    fit: BoxFit.fitWidth,
                    width: 240,
                    filterQuality: FilterQuality.high,
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  //Hello Again!
                  Text(
                    'Hello There',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 52,
                    ),
                    //TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Register below with your details!',
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
                        prefixIcon: Icon(Icons.email,
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

                  //Confirm password textfield
                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      obscureText: hideConfirmPassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: confirmPasswordController,
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
                              hideConfirmPassword = false;
                            });

                            return true;
                          },
                          onEndIconPress: () {
                            setState(() {
                              hideConfirmPassword = true;
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
                        hintText: 'Confirm Password',
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

                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //GestureDetector -> used to detect the user's actions on the application.
                    //It is a non-visual widget that detects events on its child widgets.
                    //onTap, onDoubleTap, onLongPress...
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex('#1d8247'),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          'Sign Up',
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
                        'I am a member!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          ' Login now',
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
