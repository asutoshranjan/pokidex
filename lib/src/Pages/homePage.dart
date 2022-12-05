import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_flutter/src/Classes/pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "https://rickandmortyapi.com/api/character";
  String output = "";
  List<Pokemon> pokemons = [];

  Future<http.Response?> fetchPokemon() async {
    final responses = await http.get(Uri.parse(url));
    if(responses.statusCode == 200) {
      Map<String, dynamic> response = jsonDecode(responses.body);
      var results = response["results"];
      for(int i=0; i<results.length; i++){
        var character = results[i] as Map<String, dynamic>;
        setState(() {
          pokemons.add(Pokemon.fromJson(character));
        });
      }
    }
    else {
      setState(() {
        output = "Failed to load Pokemon's";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPokemon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemon App"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: pokemons.length,
        itemBuilder: (context, index) {
            Pokemon p = pokemons[index];
            return ListTile(title: Text(p.name),);
        }
      ),
    );
  }
}
