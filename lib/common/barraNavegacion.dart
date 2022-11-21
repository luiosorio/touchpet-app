import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/myPets.dart';
import 'package:flutter_application_2/pages/myProfile.dart';

class BarraNavegacion extends StatelessWidget {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: MyPets(),
    ),
    Center(
      child: MyProfile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Mascotas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity), label: 'Perfil'),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        _selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  _widgetOptions[_selectedIndex]),
        );
      },
    );
  }
}
