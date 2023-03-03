// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_fin_de_curso/quiz/classes/question.dart';
import 'package:proyecto_fin_de_curso/quiz/classes/quiz.dart';
import 'package:proyecto_fin_de_curso/util.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late int totalQuestions;
  int totalOptions = 4;
  int questionIndex = 0;
  Quiz quiz = Quiz(name: '¿Cuál es este Pokemon?', questions: []);

  bool _blackImage = true;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/quiz.json');
    final List<dynamic> data = await json.decode(response);

    totalQuestions = data.length;

    List<int> optionList = List<int>.generate(data.length, (i) => i);
    List<int> questionAdded = [];

    while (true) {
      optionList.shuffle();
      int answer = optionList[0];

      if (questionAdded.contains(answer)) continue;
      questionAdded.add(answer);
      // print(answer);

      List<String> otherOptions = [];
      for (var option in optionList.sublist(1, totalOptions)) {
        otherOptions.add(data[option]['Pokemon']);
      }

      Question question = Question.fromJson(data[answer]);
      // print(data[answer]);
      question.addOptions(otherOptions);
      quiz.questions.add(question);

      if (quiz.questions.length >= totalQuestions) break;
    }

    //notifica al framework de que el estado interno del objeto ha cambiado,
    //provocando la actualización de la interfaz de usuario.
    setState(() {});
  }

  void _toogleImageMode() {
    setState(() {
      _blackImage = !_blackImage;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#9dcead'),
      appBar: AppBar(
        title: Text(quiz.name),
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
            child: quiz.questions.isNotEmpty
                ? Card(
                  //e6f3eb
                    color: HexColor.fromHex("#c3e1cd"),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            margin: const EdgeInsets.all(15),
                            child: _blackImage
                                ? Image(
                                    image: NetworkImage(quiz
                                        .questions[questionIndex]
                                        .pokemonImgUrl),
                                    fit: BoxFit.cover,
                                    width: 250,
                                    color: Colors.black,
                                  )
                                : Image(
                                    image: NetworkImage(quiz
                                        .questions[questionIndex]
                                        .pokemonImgUrl),
                                    fit: BoxFit.cover,
                                    width: 200,
                                  )),
                        Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    onPressed: () {},
                                    color: HexColor.fromHex('#1d8247'),
                                    child: Text(
                                      quiz.questions[questionIndex].options[0],
                                    ),
                                    minWidth: 150,
                                    height: 40,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    color: HexColor.fromHex('#9dbece'),
                                    child: Text(
                                      quiz.questions[questionIndex].options[1],
                                    ),
                                    minWidth: 150,
                                    height: 40,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {},
                                      color: HexColor.fromHex('#a5ce9d'),
                                      child: Text(
                                        quiz.questions[questionIndex]
                                            .options[2],
                                      ),
                                      minWidth: 150,
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    MaterialButton(
                                      onPressed: () {},
                                      color: HexColor.fromHex('#ce9dbe'),
                                      child: Text(
                                        quiz.questions[questionIndex]
                                            .options[3],
                                      ),
                                      minWidth: 150,
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
        TextButton(onPressed: () {_toogleImageMode();}, child: const Text('Skip'))
      ]),
    );
  }
}
