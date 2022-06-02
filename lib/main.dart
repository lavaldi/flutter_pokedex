import 'package:flutter/material.dart';
import 'package:flutter_pokedex/datamanager.dart';
import 'package:flutter_pokedex/models/pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: FutureBuilder(
        future: dataManager.getPokemon(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<Pokemon> pokemon = snapshot.data as List<Pokemon>;
            return ListView.builder(
              itemCount: pokemon.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(pokemon[index].name),
                );
              }),
            );
          } else {
            if (snapshot.hasError) {
              // Data is not there, because of an error
              return const Text("There was en error");
            } else {
              // Data is in progress (the future didn't finish)
              return const Center(child: CircularProgressIndicator());
            }
          }
        }),
      ),
    );
  }
}
