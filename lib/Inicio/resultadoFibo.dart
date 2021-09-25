import 'package:flutter/material.dart';

class ResultadoFibo extends StatefulWidget {
  final int value;
  ResultadoFibo(this.value);
  @override
  _ResultadoFiboState createState() => _ResultadoFiboState();
}

class _ResultadoFiboState extends State<ResultadoFibo> {
  int value;
  List<int> resultado;

  @override
  void initState() {
    value = widget.value;
    resultado = calcularFibonacci(value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Center(
            child: ListView.separated(
                itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "${index + 1}: ${resultado[index]}",
                      style: TextStyle(fontSize: 18),
                    )),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.blueAccent,
                    ),
                itemCount: resultado.length)),
      ),
    );
  }

  List<int> calcularFibonacci(int valor) {
    List<int> lista = List();
    int f = 0;
    int t1 = 1;
    int t2;
    for (int i = 0; i < valor; i++) {
      t2 = f;
      f = t1 + f;
      t1 = t2;
      lista.add(t1);
    }
    return lista;
  }
}
