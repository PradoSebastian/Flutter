import 'package:flutter/material.dart';
import 'package:prueba/Telegram/Modelo/Mensaje.dart';

class CanalView extends StatelessWidget {
  List<Mensaje> mensajes;
  TextEditingController contrMensaje;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [Icon(Icons.more_vert)],
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 28),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back, color: Colors.blue, size: 22)),
              CircleAvatar(
                  radius: 20,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://assets.stickpng.com/images/585e4beacb11b227491c3399.png"))),
                  )),
              SizedBox(
                width: 10,
              ),
              Text("Canal 1",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue)),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://i.pinimg.com/originals/51/ed/c0/51edc046eb80046ee4755ee71d0f19ca.jpg")),
          ),
          Column(
            children: [listaMensajes(), textFieldMensaje()],
          )
        ],
      ),
    );
  }

  Widget listaMensajes() {
    return Expanded(
        child: ListView.builder(
            itemCount: mensajes.length,
            itemBuilder: (_, index) {
              return Container();
            }));
  }

  Widget textFieldMensaje() {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(80),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1)
                ]),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.insert_emoticon),
                SizedBox(
                  width: 10,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 60),
                  child: Scrollbar(
                      child: TextField(
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    controller: contrMensaje,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Escribe un mensaje..."),
                  )),
                ),
                Row(
                  children: [
                    Icon(Icons.link),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.camera_alt),
                  ],
                )
              ],
            ),
          )),
          Container(
              height: 45,
              width: 45,
              child: Icon(
                Icons.mic,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }
}
