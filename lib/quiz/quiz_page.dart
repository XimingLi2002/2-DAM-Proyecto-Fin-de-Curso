// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_fin_de_curso/util.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#9dcead'),
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: HexColor.fromHex("#9dcead"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: ClipRRect(
            child: LinearProgressIndicator(
              color: HexColor.fromHex("#1d8247"),
              value: 0.5,
              minHeight: 20,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 450),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Text('Pregunta 1'),
                  ),
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.all(3),
                            // decoration: BoxDecoration(
                            //     border: Border.all(
                            //         color: HexColor.fromHex("#be76a6"),
                            //         width: 2),
                            //     borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              leading: Text('${index + 1}'),
                              title: Text('Respuesta'),
                              onTap: () {},
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        TextButton(onPressed: () {}, child: const Text('Skip'))
      ]),
    );
  }
}
