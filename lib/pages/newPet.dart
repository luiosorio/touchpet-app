import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/common/barraNavegacion.dart';
import 'package:flutter_application_2/model/pet.dart';
import 'package:flutter_application_2/pages/myPets.dart';
import 'package:http/http.dart' as http;

Future<Pet?> createPet(String userId, String nombreMascota, String raza,
    String tamanio, String personalidad, String peso, String fecha) async {
  try {
    double pesoDouble = double.parse(peso);
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/users/${userId}/pets'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "nombre": nombreMascota,
        "raza": raza,
        "tamanio": tamanio,
        "fechaCumpleanios": fecha,
        "personalidad": personalidad,
        "kgs": pesoDouble
      }),
    );

    if (response.statusCode == 201) {
      return Pet.fromJson(jsonDecode(response.body));
    } else {
      // return 'Failed to create pet.';
      return null;
    }
  } catch (e) {
    print(e.toString());
    // throw Exception('Failed to create pet.');
    // return 'Failed to create pet....';
    return null;
  }
}

Future<void> _showMyDialog(
    BuildContext context, String title, String subtitle) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text(subtitle)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class NewPet extends StatelessWidget {
  const NewPet({super.key, required this.userId});

  // Declare a field that holds the Todo.
  final String userId;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _ctrlrName = TextEditingController();
    final TextEditingController _ctrlrRaza = TextEditingController();
    final TextEditingController _ctrlrTamanio = TextEditingController();
    final TextEditingController _ctrlrPersonalidad = TextEditingController();
    final TextEditingController _ctrlrPeso = TextEditingController();
    final TextEditingController _ctrlrFecha = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Crear Mascota")),
      bottomNavigationBar: BarraNavegacion(),
      body: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(height: 8),
        Image.asset('home.png', height: 130, width: 180),
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
                    child: Text("Diligencia los datos para crear tu mascota")),
              ]))
        ]),
        const SizedBox(
          height: 10,
          width: 0.5,
        ),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _InputName(_ctrlrName)),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _InputRace(_ctrlrRaza)),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _InputTamanio(_ctrlrTamanio)),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _InputPersonality(_ctrlrPersonalidad)),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _InputWeight(_ctrlrPeso)),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _InputFechaCumpleanios(_ctrlrFecha)),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
            margin: const EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: () {
                  // recolectamos la data de todos los campos y la enviamos al metodo de creacion de mascota
                  createPet(
                          userId,
                          _ctrlrName.text,
                          _ctrlrRaza.text,
                          _ctrlrTamanio.text,
                          _ctrlrPersonalidad.text,
                          _ctrlrPeso.text,
                          _ctrlrFecha.text)
                      .then((value) => {
                            if (value != null && value.nombre != "")
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyPets()),
                                )
                              }
                            else
                              {
                                _showMyDialog(context, "Error",
                                    "Error creando la mascota, verifique la información ingresada.")
                              }
                          });
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                child: const Text('Crear Mascota'))),
      ])),
    );
  }

  Container _InputName(controller) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              hintText: "Nombre de la Mascota", border: InputBorder.none),
        ));
  }

  Container _InputRace(controller) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20),
          decoration:
              const InputDecoration(hintText: "Raza", border: InputBorder.none),
        ));
  }

  Container _InputWeight(controller) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              hintText: "Peso en KGS", border: InputBorder.none),
        ));
  }

  Container _InputPersonality(controller) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              hintText: "Personalidad", border: InputBorder.none),
        ));
  }

  Container _InputTamanio(controller) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              hintText: "Tamaño de la Mascota", border: InputBorder.none),
        ));
  }

  Container _InputFechaCumpleanios(controller) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              hintText: "Fecha de Cumpleaños", border: InputBorder.none),
        ));
  }
}
