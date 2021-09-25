import 'package:flutter/material.dart';
import '../Modelo/Canal.dart';
import '../Modelo/Mensaje.dart';
import 'nuevoCanal.dart';

class Canales extends StatefulWidget {
  @override
  _CanalesState createState() => _CanalesState();
}

class _CanalesState extends State<Canales> {
  TextEditingController busquedaController;
  List<Canal> listCanales;

  @override
  void initState() {
    busquedaController = TextEditingController();
    listCanales = List();
    obtenerCanales();
    super.initState();
  }

  void obtenerCanales() {
    for (int i = 0; i < 10; i++) {
      var c = Canal(
          nombre: "Canal $i",
          imagen:
              "https://assets.stickpng.com/images/585e4beacb11b227491c3399.png",
          administradores: [
            "1",
            "2",
            "3"
          ],
          usuarios: [
            "uid1",
            "uid2",
            "uid3"
          ],
          mensajes: [
            Mensaje(
                contenido: "Hola mundo!",
                fecha: DateTime(
                  2021,
                  1,
                  1,
                  6,
                  40,
                ).toUtc(),
                emisor: "1")
          ]);

      listCanales.add(c);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 36,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NuevoCanal()));
                  },
                )),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(children: [
              Center(
                child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: TextField(
                      controller: busquedaController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: "Buscar por nombre del canal ",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8)),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
              ),
              Container(
                child: ListaCanales(busquedaController.text, listCanales),
              ),
            ])));
  }
}

class ListaCanales extends StatelessWidget {
  final String textoBusqueda;
  final List<Canal> canales;

  ListaCanales(this.textoBusqueda, this.canales);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            child: SingleChildScrollView(
      child: Column(
        children: obtenerCanalesFiltrados(context),
      ),
    )));
  }

  String obtenerFechaMensaje(DateTime fecha) {
    DateTime hoy = DateTime.now().toUtc();
    String resultado;
    int days = hoy.difference(fecha).inDays;

    if (days < 1) {
      var min = fecha.minute < 10 ? "0${fecha.minute}" : "${fecha.minute}";
      var hour = fecha.hour < 10 ? "0${fecha.hour}" : "${fecha.hour}";
      resultado = "$hour:$min";
    } else if (days == 1) {
      resultado = "Ayer";
    } else if (days > 1 && days < 7) {
      var dias = [
        "Lunes",
        "Martes",
        "Miercoles",
        "Jueves",
        "Viernes",
        "Sabado",
        "Domingo"
      ];
      resultado = "${dias[fecha.weekday - 1]}";
    } else {
      resultado = "${fecha.day}/${fecha.month}/${fecha.year}";
    }
    return resultado;
  }

  List<Widget> obtenerCanalesFiltrados(BuildContext context) {
    List<Widget> tiles = List();

    for (var c in canales) {
      if (c.nombre.toLowerCase().contains(textoBusqueda.toLowerCase())) {
        ListTile aux = ListTile(
          leading: CircleAvatar(
            child: Image(
              image: NetworkImage(c.imagen),
            ),
            radius: 30,
          ),
          title: Row(
            children: [
              Expanded(
                  child: Container(
                      child: Text(
                c.nombre,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ))),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  obtenerFechaMensaje(c.mensajes[c.mensajes.length - 1].fecha),
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
              )
            ],
          ),
          subtitle: Text(c.mensajes[c.mensajes.length - 1].contenido,
              style: TextStyle(fontSize: 15)),
        );

        tiles.add(aux);
        tiles.add(Divider(
          height: 0,
          indent: 70,
        ));
      }
    }

    return tiles;
  }
}
