import 'dart:math';

import 'package:flutter/material.dart';

class GuessGame extends StatefulWidget {
  @override
  _GuessGameState createState() => _GuessGameState();
}

class _GuessGameState extends State<GuessGame> {
  TextEditingController controller;
  int intentos;
  String mensaje;
  int random;
  bool outOfRange;
  bool winner;

  @override
  void initState() {
    random = Random().nextInt(50);
    intentos = 0;
    mensaje = "";
    controller = TextEditingController();
    outOfRange = false;
    winner = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Game")),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ingrese un número entre 0 y 50",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Número...",
                        errorText: outOfRange
                            ? "El número ingresado está fuera de rango"
                            : null,
                        errorStyle: TextStyle(fontSize: 15)),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      "Jugar!",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: winner ? null : jugar,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Mensaje: $mensaje",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Intentos: $intentos",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void jugar() {
    setState(() {
      if (controller.text.isNotEmpty) {
        int value = int.parse(controller.text);
        if (value > 50 || value < 0) {
          outOfRange = true;
        } else {
          intentos++;
          if (value == random) {
            mensaje = "$value es el número ganador";
            winner = true;
          } else if (value > random) {
            mensaje = "El número $value es mayor";
          } else if (value < random) {
            mensaje = "El número $value es menor";
          }
          controller.clear();
        }
      }
    });
  }
}
