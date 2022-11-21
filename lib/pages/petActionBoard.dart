import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_application_2/common/barraNavegacion.dart';
import 'package:flutter_application_2/model/pet.dart';
import 'package:flutter_application_2/model/petAction.dart';

Future<PetAction?> createPetAction(
    String userId, String nombreMascota, String accion) async {
  try {
    final response = await http.post(
      Uri.parse(
          'http://localhost:5000/api/users/${userId}/pets/${nombreMascota}/acciones'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"accion": accion}),
    );

    if (response.statusCode == 201) {
      return PetAction.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}

late Pet pet1;
late String userId1;

class PetActionBoard extends StatefulWidget {
  PetActionBoard({super.key, required this.pet, required this.userId}) {
    pet1 = pet;
    userId1 = userId;
  }

  // Declare a field that holds the Todo.
  final Pet pet;
  final String userId;

  @override
  // ignore: no_logic_in_create_state
  State<PetActionBoard> createState() => PetActionBoardX();
}

class PetActionBoardX extends State<PetActionBoard> {
  @override
  void initState() {
    super.initState();
  }

  late String successMesage = "ok";

  callCreatePetAction(String accion) {
    createPetAction(userId1, pet1.nombre, accion).then((value) => {
          if (value != null && value.accion != "")
            {successMesage = "Accion ${value.accion} registrada con exito"}
          else
            {successMesage = "Error registrando la accion"}
        });
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
              Text("Nombre: ${pet1.nombre} - ${pet1.raza}"),
            ])),
        Container(
          margin: const EdgeInsets.all(15),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(children: [
            const Text('Seleccione un boton para registrar una accion:'),
          ]),
        ),
        Row(children: [
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("Comida");
                  },
                  child: const Text("Comida"))),
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("Agua");
                  },
                  child: const Text("Agua"))),
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("Afuera");
                  },
                  child: const Text("Afuera")))
        ]),
        Row(children: [
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("Aburrido");
                  },
                  child: const Text("Aburrido"))),
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("Jugar");
                  },
                  child: const Text("Jugar"))),
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("Mimos");
                  },
                  child: const Text("Mimos")))
        ]),
        Row(children: [
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("Miedo");
                  },
                  child: const Text("Miedo"))),
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("Si");
                  },
                  child: const Text("Si"))),
          Container(
              margin: const EdgeInsets.all(15),
              width: 160,
              child: ElevatedButton(
                  onPressed: () {
                    callCreatePetAction("No");
                  },
                  child: const Text("No")))
        ]),
        Container(
          margin: const EdgeInsets.all(15),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(children: [
            Text(successMesage),
          ]),
        ),
      ])),
    );
  }
}
