import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NuevoCanal extends StatefulWidget {
  @override
  _NuevoCanalState createState() => _NuevoCanalState();
}

class _NuevoCanalState extends State<NuevoCanal> {
  TextEditingController nombreContr;
  TextEditingController descContr;

  File imageFile;

  openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Seleccione el metodo para incluir la imagen"),
            content: SingleChildScrollView(
              child: ListBody(children: [
                Container(
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Icon(Icons.image, size: 18),
                        Container(
                          child: Text(
                            "Galeria",
                            style: TextStyle(fontSize: 18),
                          ),
                          margin: EdgeInsets.only(left: 5),
                        ),
                      ],
                    ),
                    onTap: () => openGallery(context),
                  ),
                  margin: EdgeInsets.only(top: 5),
                ),
                Container(
                  child: GestureDetector(
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt, size: 18),
                          Container(
                            child:
                                Text("Camara", style: TextStyle(fontSize: 18)),
                            margin: EdgeInsets.only(left: 5),
                          ),
                        ],
                      ),
                      onTap: () => openCamera(context)),
                  margin: EdgeInsets.only(top: 10),
                )
              ]),
            ),
          );
        });
  }

  Widget decideImageView() {
    if (imageFile != null) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(fit: BoxFit.fill, image: FileImage(imageFile))),
      );
    } else {
      return Icon(
        Icons.camera_alt,
        color: Colors.grey[500],
        size: 36,
      );
    }
  }

  @override
  void initState() {
    nombreContr = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
        title: Text(
          "Nuevo Canal",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blue),
        actions: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(right: 20),
            child: InkWell(
              child: Text(
                "Create",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            color: Colors.blue[300],
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 15, top: 5),
                    child: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.room_service, size: 30),
                        radius: 30,
                      ),
                    )),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                      "Podras difundir tus mensajes a grandes comunidades",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ))
              ],
            )),
        Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15, top: 5),
                        child: GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: decideImageView(),
                            radius: 40,
                          ),
                          onTap: () => showChoiceDialog(context),
                        )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        controller: nombreContr,
                        decoration: InputDecoration(
                            hintText: "Nombre del canal...",
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(top: 10, bottom: 10)),
                        style: TextStyle(fontSize: 20),
                      ),
                    ))
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Divider(
                      height: 0,
                      color: Colors.grey[900],
                      indent: 20,
                      endIndent: 20,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextField(
                    controller: descContr,
                    decoration: InputDecoration(
                        hintText: "Añadir una descripción...",
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: 10, bottom: 10)),
                  ),
                )
              ],
            )),
      ]),
    );
  }
}
