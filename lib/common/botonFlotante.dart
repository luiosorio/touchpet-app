import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/myProfile.dart';

class BotonFlotante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      highlightElevation: 0,
      child: const Icon(Icons.add),
      onPressed: () {
        print('Hola mundo');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MyProfile()),
        );
      },
    );
  }
}
