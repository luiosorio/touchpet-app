import 'package:flutter/material.dart';
import 'package:flutter_application_2/common/barraNavegacion.dart';
import 'package:flutter_application_2/model/pet.dart';
import 'package:flutter_application_2/pages/newPet.dart';
import 'package:flutter_application_2/pages/petDetails.dart';

import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;

const identificacionCliente = "1098313090";

Future<PetList> fetchPets() async {
  final response = await http.get(Uri.parse(
      'http://localhost:5000/api/users/${identificacionCliente}/pets'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PetList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pets');
  }
}

class MyPets extends StatefulWidget {
  const MyPets({super.key});

  @override
  State<MyPets> createState() => _myPetsX();
}

class _myPetsX extends State<MyPets> {
  late Future<PetList> futurePets;

  @override
  void initState() {
    super.initState();
    futurePets = fetchPets();
    log('data: $futurePets');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Mis Mascotas")),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: BotonFlotante(),
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
                        child: Text(
                            "Elige la mascota para visualizar la informacion")),
                  ]))
            ]),
            Container(
              child: FutureBuilder<PetList>(
                future: futurePets,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var numItems = snapshot.data?.pets.length;
                    return DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                            label: Text(
                          "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                          label: Text(
                            'Mis Mascotas',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        numItems!,
                        (int index) => DataRow(
                          cells: <DataCell>[
                            // ignore: prefer_const_constructors
                            DataCell(
                                Image.asset(
                                    "examples/${snapshot.data?.pets[index].raza}.png",
                                    height: 80,
                                    width: 80), onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PetDetails(
                                        pet: snapshot.data?.pets[index],
                                        userId: identificacionCliente)),
                              );
                            }),
                            DataCell(
                                Text(
                                    "${snapshot.data?.pets[index].nombre} - ${snapshot.data?.pets[index].raza} - ${snapshot.data?.pets[index].tamanio}  "),
                                onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PetDetails(
                                        pet: snapshot.data?.pets[index],
                                        userId: identificacionCliente)),
                              );
                            })
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
            ),
            Container(
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewPet(userId: identificacionCliente)),
                      );
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: const Text('Agregar Mascota'))),
            Container()
          ]),
        ));
  }
}
