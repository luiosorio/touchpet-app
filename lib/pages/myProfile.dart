import 'package:flutter/material.dart';
import 'package:flutter_application_2/common/barraNavegacion.dart';
import 'package:flutter_application_2/common/botonFlotante.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mi Perfil")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BotonFlotante(),
      bottomNavigationBar: BarraNavegacion(),
    );
  }
}
