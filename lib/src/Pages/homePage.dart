import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=100";
  String output = "";
  List<String> names = [];

  Future<http.Response?> fetchPokemon() async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> result = jsonDecode(response.body);
      List pokes = result["results"];
      setState(() {
        for(int i=0; i<pokes.length; i++){
          Map<String, dynamic> pok = pokes[i];
          setState(() {
            names.add(pok["name"]);
          });
        }
        output = response.body;
      });
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
          itemCount: names.length,
        itemBuilder: (context, index) {
            return ListTile(title: Text(names[index]),);
        }
      ),
    );
  }
}
