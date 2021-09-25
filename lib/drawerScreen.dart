import 'package:flutter/material.dart';
import 'package:prueba/main.dart';

class DrawerScreen extends StatefulWidget {
  final MyAppState main;
  DrawerScreen(this.main);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Ejemplo"),
            currentAccountPicture: CircleAvatar(
                child: Image(
              image: NetworkImage(
                  "https://assets.stickpng.com/images/585e4beacb11b227491c3399.png"),
            )),
            accountEmail: Text("ejemplo@gmail.com"),
          ),
          DrawerListTile(
            iconData: Icons.note,
            title: 'Practica Compumovil',
            onTilePressed: () {
              Navigator.of(context).pop();
              widget.main.onSelectItem(0);
            },
          ),
          DrawerListTile(
            iconData: Icons.message,
            title: 'Telegram',
            onTilePressed: () {
              Navigator.of(context).pop();
              widget.main.onSelectItem(1);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTilePressed;

  const DrawerListTile({Key key, this.iconData, this.title, this.onTilePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
