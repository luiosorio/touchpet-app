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

  ButtonStyle get buttonStyle => ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      )));

  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 120;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Simulador de Tapete",
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
              )
            ])),
        Row(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                const Icon(
                  Icons.info,
                  color: Colors.blueAccent,
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child:
                        Text("Presione un botón para registrar una accion:")),
              ]))
        ]),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("tapete1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          width: 550,
          height: 270,
          padding: const EdgeInsets.all(25),
          child: Column(children: [
            Row(children: [
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("Comida");
                      },
                      style: buttonStyle,
                      child: const Text("Comida"))),
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("Agua");
                      },
                      style: buttonStyle,
                      child: const Text("Agua"))),
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("Afuera");
                      },
                      style: buttonStyle,
                      child: const Text("Afuera")))
            ]),
            Row(children: [
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("Aburrido");
                      },
                      style: buttonStyle,
                      child: const Text("Aburrido"))),
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("Jugar");
                      },
                      style: buttonStyle,
                      child: const Text("Jugar"))),
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("Mimos");
                      },
                      style: buttonStyle,
                      child: const Text("Mimos")))
            ]),
            Row(children: [
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("Miedo");
                      },
                      style: buttonStyle,
                      child: const Text("Miedo"))),
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("Si");
                      },
                      style: buttonStyle,
                      child: const Text("Si"))),
              Container(
                  margin: const EdgeInsets.all(15),
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: () {
                        callCreatePetAction("No");
                      },
                      style: buttonStyle,
                      child: const Text("No")))
            ]),
          ]),
        ),
      ])),
    );
  }
}
