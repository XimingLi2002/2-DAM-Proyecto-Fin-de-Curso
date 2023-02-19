// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()){
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    }
  }
  bool passwordConfirmed(){
    if (passwordController.text.trim() == confirmPasswordController.text.trim()){
      return true;
    }else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade200,
        body: SafeArea(
          child: Center(
            //Evita que el teclado se sobreponga sobre los componentes
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Imagen
                  //Se puede ver el tamaño de la imagen si le pontemos lo almacenamos en un Container y le damos un color (es decir el background)
                  Image(image: AssetImage('assets/logo.png'), fit: BoxFit.fitWidth, width: 240, filterQuality: FilterQuality.high,),
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

                  //Confirm password textfield
                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      obscureText: true,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                          //enabledBorder -> The border to display when is enabled and is not showing an error.
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          //focusBorder -> The border to display when has the focus and is not showing an error.
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          hintText: 'Confirm Password',
                          //Color del background del TextField
                          fillColor: Colors.grey[200],
                          filled: true),
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
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12)),
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
