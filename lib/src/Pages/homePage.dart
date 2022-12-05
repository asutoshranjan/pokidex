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
  String nurl = "";
  int page = 1;
  String output = "";
  bool loading = true;
  List<Pokemon> pokemons = [];

  Future<http.Response?> fetchPokemon(String uri) async {
    final responses = await http.get(Uri.parse(uri));
    if (responses.statusCode == 200) {
      setState(() {
        loading = true;
      });
      Map<String, dynamic> response = jsonDecode(responses.body);
      var results = response["results"];
      for (int i = 0; i < results.length; i++) {
        var character = results[i] as Map<String, dynamic>;
        setState(() {
          pokemons.add(Pokemon.fromJson(character));
        });
      }
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        output = "Failed to load Pokemon's";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPokemon(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick and Morty"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 1,
            child: Text(
              "Page - $page",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (page > 1) {
                      setState(() {
                        page -= 1;
                        pokemons = [];
                        loading = true;
                        nurl = url + "?page=$page";
                        fetchPokemon(nurl);
                      });
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: page == 1 ? Colors.grey : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (page <= 41) {
                      setState(() {
                        page += 1;
                        pokemons = [];
                        loading = true;
                        nurl = url + "?page=$page";
                        fetchPokemon(nurl);
                      });
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: page == 42 ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 10,
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: pokemons.length,
                    itemBuilder: (context, index) {
                      Pokemon p = pokemons[index];
                      return ListTile(
                        title: Text(p.name),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
