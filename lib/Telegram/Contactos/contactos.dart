import 'package:flutter/material.dart';
import 'package:prueba/Telegram/Contactos/nuevoContacto.dart';

import '../Modelo/Contacto.dart';

class Contactos extends StatefulWidget {
  @override
  _ContactosState createState() => _ContactosState();
}

class _ContactosState extends State<Contactos> {
  TextEditingController busquedaController;
  List<Contacto> listContactos;
  Contacto infoPropia;

  @override
  void initState() {
    busquedaController = TextEditingController();
    listContactos = List();
    obtenerContactos();
    obtenerInfoContactoPropia();
    super.initState();
  }

  void obtenerInfoContactoPropia() {
    var c = Contacto(
        nombre: "Yo",
        nickName: "Yo, quien más? :v",
        enLinea: true,
        telefono: "+57 1234567",
        ultimaConexion: DateTime(
          2020,
          12,
          24,
          21,
          46,
        ),
        imagenPerfil:
            "https://assets.stickpng.com/images/585e4beacb11b227491c3399.png");

    infoPropia = c;
  }

  void obtenerContactos() {
    for (int i = 0; i < 10; i++) {
      var c = Contacto(
          nombre: "Nombre $i",
          nickName: "Nick $i",
          enLinea: i % 2 == 0,
          telefono: "1234567$i",
          ultimaConexion: DateTime(
            2020,
            12,
            24,
            22,
            46,
          ).toUtc(),
          imagenPerfil:
              "https://assets.stickpng.com/images/585e4beacb11b227491c3399.png");

      listContactos.add(c);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Contactos",
          style: TextStyle(color: Colors.black),
        ),
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
                      MaterialPageRoute(builder: (context) => NuevoContacto()));
                },
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Center(
              child: Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: TextField(
                    controller: busquedaController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        hintText: "Buscar por nombre o nickname ",
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
              margin: EdgeInsets.only(top: 5),
              child: ListTile(
                leading: CircleAvatar(
                  child: Image(
                    image: NetworkImage(infoPropia.imagenPerfil),
                  ),
                  radius: 30,
                ),
                title: Text(infoPropia.nombre,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  infoPropia.telefono,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              child: Text(
                "CONTACTS",
                style: TextStyle(color: Colors.grey),
              ),
              width: double.infinity,
              color: Colors.grey[200],
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
            ),
            Container(
              child: ListaContactos(busquedaController.text, listContactos),
            )
          ],
        ),
      ),
    );
  }
}

class ListaContactos extends StatelessWidget {
  final String textoBusqueda;
  final List<Contacto> contactos;

  ListaContactos(this.textoBusqueda, this.contactos);

  Text calcularDiferencia(DateTime fecha) {
    DateTime hoy = DateTime.now().toUtc();
    String resultado;
    TextStyle stilo = TextStyle();
    int mins = hoy.difference(fecha).inMinutes;
    /* print("HOY: ${hoy.timeZoneName}");
    print("FECHA: ${fecha.timeZoneName}"); */
    if (mins < 1) {
      resultado = "En linea";
      stilo = TextStyle(color: Colors.blue);
    } else if (mins >= 60 && mins < 1440) {
      if (mins / 60 < 2)
        resultado = "Última conexión hace 1 hora";
      else
        resultado = "Última conexión hace ${(mins / 60).round()} horas";
    } else if (mins >= 1 && mins < 60) {
      if (mins < 2)
        resultado = "Última conexión hace 1 minuto";
      else
        resultado = "Última conexión hace $mins minutos";
    } else if (mins >= 1440) {
      if (mins / 1440 < 2)
        resultado = "Última conexión hace 1 día";
      else
        resultado = "Última conexión hace ${(mins / 1440).round()} días";
    }

    return Text(
      resultado,
      style: stilo,
    );
  }

  List<Widget> obtenerContactosFiltrados(BuildContext context) {
    List<Widget> tiles = List();
    tiles.add(ListTile(
      leading: Icon(
        Icons.group_add_outlined,
        color: Colors.blue,
        size: 36,
      ),
      title: Text("Invitar amigos",
          style: TextStyle(color: Colors.blue, fontSize: 18)),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NuevoContacto())),
    ));
    tiles.add(Divider(
      height: 0,
      indent: 70,
    ));

    for (var c in contactos) {
      if (c.nombre.toLowerCase().contains(textoBusqueda.toLowerCase()) ||
          c.nickName.toLowerCase().contains(textoBusqueda.toLowerCase())) {
        ListTile aux = ListTile(
          leading: CircleAvatar(
            child: Image(
              image: NetworkImage(c.imagenPerfil),
            ),
          ),
          title: Text(
            c.nombre,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: c.enLinea
              ? Text(
                  "En linea",
                  style: TextStyle(color: Colors.blue),
                )
              : calcularDiferencia(c.ultimaConexion),
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            child: SingleChildScrollView(
      child: Column(
        children: obtenerContactosFiltrados(context),
      ),
    )));
  }
}
