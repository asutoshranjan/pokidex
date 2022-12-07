import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  final String name;
  final String image;
  final String species;
  final String gender;
  final String status;
  const CharacterTile(
      {Key? key,
      required this.name,
      required this.image,
      required this.species,
      required this.gender,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Image.network(image),
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    width: 0.7*screenwidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          species,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: species == "Human"
                                  ? Colors.deepPurple
                                  : Colors.blueGrey
                          ),
                        ),
                        Text(
                          gender,
                          style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                              color: gender == "Male"
                                  ? Colors.blueAccent
                                  : Colors.pinkAccent
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: status == "Alive"
                                  ? Colors.green
                                  : Colors.red
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
