import 'package:flutter/material.dart';
import 'package:prueba/Inicio/resultadoFibo.dart';
import 'package:url_launcher/url_launcher.dart';

class Fibonacci extends StatefulWidget {
  @override
  _FibonacciState createState() => _FibonacciState();
}

class _FibonacciState extends State<Fibonacci> {
  TextEditingController controller;
  bool error;

  @override
  void initState() {
    controller = TextEditingController();
    error = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fibonacci"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Center(
            child: Column(
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              child: InkWell(
                child: Image(
                  image: AssetImage("assets/images/fibo.jpg"),
                ),
                onTap: () =>
                    launch('https://es.wikipedia.org/wiki/Leonardo_de_Pisa'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Número de calculos...",
                    errorText: error ? "Ingrese un número mayor a 0" : null),
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: RaisedButton(
                onPressed: calcular,
                color: Colors.blue,
                textColor: Colors.white,
                child: Text(
                  "Calcular",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  void calcular() {
    setState(() {
      if (controller.text.isNotEmpty) {
        int value = int.parse(controller.text);
        if (value <= 0) {
          error = true;
        } else {
          error = false;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ResultadoFibo(value)));
        }
      }
    });
  }
}
