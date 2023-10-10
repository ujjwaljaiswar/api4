import 'dart:convert';
import 'package:api4/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POKEMONS"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final id = users[index];
            final pokemon = id.pokemon;
            final types = id.types;

            return ListTile(
              title: Text(pokemon),
              subtitle: Text(types),
              leading: Image.network(id.image_url),            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: FetchData,
      ),
    );
  }

  void FetchData() async {
    print("hello data");
    const url = 'https://dummyapi.online/api/pokemon';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);

      final user = User(
        id: json['id'],
        pokemon: json['pokemon'],
        types: json['types'],
        abilities: json['abilities'],
        hitpoints: json['hitpoints'],
        evolutions: json['evolutions'],
        location: json['location'],
        image_url: json['imageurl'],
      );

      setState(() {
        users = [user];
      });

      print("END");
    }
    else {
      print("HTTP Error: ${response.statusCode}");
    }
  }

}


