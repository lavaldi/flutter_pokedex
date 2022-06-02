import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/pokemon.dart';

class DataManager {
  List<Pokemon>? pokemon;

  fetchPokemon() async {
    const url = 'https://pokeapi.co/api/v2/pokemon/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(response.body)['results'];
      pokemon = results.map((item) => Pokemon.fromJson(item)).toList();
    } else {
      throw 'Request failed with status ${response.statusCode}';
    }
  }

  Future<List<Pokemon>> getPokemon() async {
    if (pokemon == null) {
      await fetchPokemon();
    }
    return pokemon ?? [];
  }
}
