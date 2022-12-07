import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_flutter/src/Classes/rmCharacter.dart';
import 'package:rest_flutter/src/Widgets/characterTile.dart';

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
  List<RMCharacter> pokemons = [];
  List<RMCharacter> searchPok = [];
  String prevValue = "";
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
          pokemons.add(RMCharacter.fromJson(character));
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

  void searchQuery(String query) {
    for(var pokemon in pokemons){
      if(pokemon.name.toLowerCase().contains(query.toLowerCase())){
        setState(() {
          searchPok.add(pokemon);
        });
      }
    }
    print("Search Result");
    for(var pokemon in searchPok){
      print(pokemon.name);
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
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick and Morty"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 0.03 * screenheight,
              child: Text(
                "Page - $page",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 0.06 * screenheight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (page > 1) {
                        setState(() {
                          page -= 1;
                          pokemons = [];
                          searchPok = [];
                          loading = true;
                          nurl = url + "?page=$page";
                          prevValue = "";
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
                          searchPok = [];
                          loading = true;
                          nurl = url + "?page=$page";
                          prevValue = "";
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
            SizedBox(
              height: 0.075 * screenheight,
              width: 0.85 * MediaQuery.of(context).size.width,
              child: TextField(
                controller: searchController,
                onSubmitted: (val) {
                  if(prevValue.toLowerCase() != val.toLowerCase()){
                    searchQuery(val);
                    setState(() {
                      prevValue = val;
                    });
                  }
                },
                onChanged: (val) {
                  setState(() {
                    searchPok = [];
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      setState(() {
                        searchPok = [];
                        prevValue = "";
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 0.7 * screenheight,
              child: searchPok.length != 0
                  ? ListView.builder(
                      itemCount: searchPok.length,
                      itemBuilder: (context, index) {
                        RMCharacter p = searchPok[index];
                        return CharacterTile(name: p.name, image: p.image, species: p.species, gender: p.gender, status: p.status);
                      })
                  : loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: pokemons.length,
                          itemBuilder: (context, index) {
                            RMCharacter p = pokemons[index];
                            return CharacterTile(name: p.name, image: p.image, species: p.species, gender: p.gender, status: p.status);
                          }),
            ),
          ],
        ),
      ),
    );
  }
}
