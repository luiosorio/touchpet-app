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
              Image.asset("examples/${pet1.raza}.png", width: 130),
            ])),
        Container(
          margin: const EdgeInsets.all(15),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    pet1.nombre,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(pet1.raza),
                  leading: Icon(
                    Icons.pets,
                    color: Colors.blue[500],
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    pet1.tamanio,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(
                    Icons.stacked_bar_chart,
                    color: Colors.blue[500],
                  ),
                ),
                ListTile(
                  title: Text(pet1.personalidad),
                  leading: Icon(
                    Icons.psychology,
                    color: Colors.blue[500],
                  ),
                ),
                ListTile(
                  title: Text(pet1.fechaCumpleanios),
                  leading: Icon(
                    Icons.cake,
                    color: Colors.blue[500],
                  ),
                ),
                ListTile(
                  title: Text("${pet1.kgs} kilos"),
                  leading: Icon(
                    Icons.scale,
                    color: Colors.blue[500],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(children: [
          Container(
              margin: const EdgeInsets.all(15),
              width: 60,
              child: ElevatedButton(
                  onPressed: () {
                    futurePetActions = fetchPetActions(userId1, pet1.nombre);
                    setState(() {});
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
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
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
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
                      'Historial de Acciones',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  numItems!,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(ListTile(
                        title: Text(
                          "${snapshot.data?.actions[index].fecha} ${snapshot.data?.actions[index].hora} - ${snapshot.data?.actions[index].accion} ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        leading: Icon(
                          Icons.calendar_month,
                          color: Colors.blue[500],
                        ),
                      ))
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
