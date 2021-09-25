import 'package:flutter/material.dart';
import 'package:prueba/Telegram/Contactos/contactos.dart';
import 'package:prueba/Telegram/Canales/canales.dart';

class TelegramHome extends StatefulWidget {
  @override
  _TelegramHomeState createState() => _TelegramHomeState();
}

class _TelegramHomeState extends State<TelegramHome> {
  int selectedIndex;

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Contactos();
      case 1:
        return Canales();
      default:
        return Center(child: Text("Configuración"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getDrawerItemWidget(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: "Contactos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined), label: "Canales"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Configuración"),
        ],
      ),
    );
  }
}
