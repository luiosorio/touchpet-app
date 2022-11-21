import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_2/pages/petActionBoard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_application_2/common/barraNavegacion.dart';
import 'package:flutter_application_2/model/pet.dart';
import 'package:flutter_application_2/model/petAction.dart';

Future<PetActionList> fetchPetActions(userId, petId) async {
  final response = await http.get(Uri.parse(
      'http://localhost:5000/api/users/${userId}/pets/${petId}/acciones'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PetActionList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load actions');
  }
}

late Pet pet1;
late String userId1;

class PetDetails extends StatefulWidget {
  PetDetails({super.key, required this.pet, required this.userId}) {
    pet1 = pet;
    userId1 = userId;
  }

  // Declare a field that holds the Todo.
  final Pet pet;
  final String userId;

  @override
  // ignore: no_logic_in_create_state
  State<PetDetails> createState() => PetDetailsX();
}

class PetDetailsX extends State<PetDetails> {
  late Future<PetActionList> futurePetActions;

  @override
  void initState() {
    super.initState();
    futurePetActions = fetchPetActions(userId1, pet1.nombre);
    log('data: $futurePetActions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Detalles de la Mascota",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      bottomNavigationBar: BarraNavegacion(),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
            margin: const EdgeInsets.all(15),
            child: Column(children: [
              const SizedBox(height: 8),
              Image.asset('pet1.png', height: 150, width: 180),
              Text("Nombre: ${pet1.nombre}"),
              Text("Raza: ${pet1.raza}"),
              Text("Tamaño: ${pet1.tamanio}"),
              Text("Personalidad: ${pet1.personalidad}"),
              Text("Fecha Cumpleaños: ${pet1.fechaCumpleanios}"),
              Text("Peso: ${pet1.kgs} Kilos"),
            ])),
        Row(children: [
          Container(
              margin: const EdgeInsets.all(15),
              width: 60,
              child: ElevatedButton(
                  onPressed: () {
                    futurePetActions = fetchPetActions(userId1, pet1.nombre);
                    setState(() {});
                  },
                  child: const Icon(Icons.refresh))),
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PetActionBoard(pet: pet1, userId: userId1)),
                    );
                  },
                  child: const Text("Simular Acciones")))
        ]),
        FutureBuilder<PetActionList>(
          future: futurePetActions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var numItems = snapshot.data?.actions.length;
              return DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Acciones',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  numItems!,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(
                            "${snapshot.data?.actions[index].fecha} ${snapshot.data?.actions[index].hora} - ${snapshot.data?.actions[index].accion} "),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ])),
    );
  }
}
