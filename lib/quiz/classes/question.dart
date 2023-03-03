class Question {
  late String pokemonImgUrl;
  late String pokemonName;
  List<String> options = [];
  String selected = 'Skipped';
  bool correct = false;

  //https://docs.flutter.dev/development/data-and-backend/json#:~:text=A%20User.fromJson()%20constructor,User%20instance%20into%20a%20map.
  Question.fromJson(Map<String, dynamic> json)
      : pokemonName = json['Pokemon'],
        pokemonImgUrl = json['PokemonImgRoute'];

  void addOptions(List<String> newOptions){
    options.add(pokemonName);
    options.addAll(newOptions);
    options.shuffle();
  }
}
