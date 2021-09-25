import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  var contador = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Contador'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              "Hola mundo",
              style: new TextStyle(fontSize: 30, color: Colors.blue),
            ),
            new Container(
              child: new Text(
                "$contador",
                style: new TextStyle(fontSize: 20, color: Colors.grey),
              ),
              margin: EdgeInsets.only(top: 10.0),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        new FloatingActionButton(
          heroTag: "btnAdd",
          child: new Icon(Icons.add),
          onPressed: aumentarContador,
        ),
        new FloatingActionButton(
          heroTag: "btnRemove",
          child: new Icon(Icons.remove),
          onPressed: disminuirContador,
        ),
      ],
    );
  }

  void aumentarContador() {
    setState(() {
      contador++;
    });
  }

  void disminuirContador() {
    setState(() {
      contador--;
    });
  }
}
