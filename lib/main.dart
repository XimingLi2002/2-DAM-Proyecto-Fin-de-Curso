// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_fin_de_curso/main_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}



















class TestImage extends StatefulWidget {
  const TestImage({super.key});

  @override
  State<TestImage> createState() => _TestImageState();
}

class _TestImageState extends State<TestImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/main_background.jpeg'),
                fit: BoxFit.contain)),
        child: TextField(decoration: InputDecoration(hintText: 'Email')),
      ),
    );
  }
}
