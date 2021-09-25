import 'Mensaje.dart';

class Canal {
  String nombre;
  String imagen;
  List<Mensaje> mensajes;
  List<String> administradores;
  List<String> usuarios;
  List<String> vistos; // vistos

  Canal(
      {this.nombre,
      this.imagen,
      this.mensajes,
      this.administradores,
      this.usuarios,
      this.vistos});
}
