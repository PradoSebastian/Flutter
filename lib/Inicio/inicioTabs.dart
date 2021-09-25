import 'package:flutter/material.dart';
import 'package:prueba/Inicio/contador.dart';
import 'package:prueba/Inicio/fibonacci.dart';
import 'package:prueba/Inicio/game.dart';

class InicioTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: new Center(
        child: new Column(
          children: [
            new Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: new Text(
                "Practica IntroCompuMovil",
                style: TextStyle(fontSize: 25, color: Colors.blueAccent),
              ),
            ),
            new Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20.0),
              child: new RaisedButton(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Contador()));
                },
                child: new Text(
                  "Contador",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            new Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10.0),
              child: new RaisedButton(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GuessGame()));
                },
                child: new Text(
                  "Game",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            new Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10.0),
              child: new RaisedButton(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Fibonacci()));
                },
                child: new Text(
                  "Fibonacci",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
