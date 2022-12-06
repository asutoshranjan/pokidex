import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  final String name;
  final String image;
  const CharacterTile({Key? key, required this.name, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  height: 60,
                  width: 60,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.network(image),
                ),
                SizedBox(width: 10,),
                Text(name, style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
