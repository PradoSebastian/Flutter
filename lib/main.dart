import 'package:flutter/material.dart';
import 'package:prueba/drawerScreen.dart';

import 'Inicio/inicioTabs.dart';
import 'Telegram/telegramHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int selectorDrawerItem = 0;

  Widget getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return InicioTabs();
      case 1:
        return GoTelegram();
      default:
        return InicioTabs();
    }
  }

  void onSelectItem(int pos) {
    setState(() {
      selectorDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabController = new DefaultTabController(
        length: 4,
        child: new Scaffold(
            appBar: new AppBar(
              title: Text("Practica"),
            ),
            drawer: DrawerScreen(this),
            body: getDrawerItemWidget(selectorDrawerItem)));
    return new MaterialApp(
      title: "Tabs con Flutter",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: tabController,
    );
  }
}

class GoTelegram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Go Telegram!"),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TelegramHome(),
          ));
        },
      ),
    );
  }
}

/* class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    final tabController = new DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: new AppBar(
            title: Center(child: new Text("Practica")),
            bottom: new TabBar(indicatorColor: Colors.red, tabs: [
              new Tab(icon: new Icon(Icons.home), text: "Inicio"),
              new Tab(icon: new Icon(Icons.contacts), text: "Contactos"),
              new Tab(icon: new Icon(Icons.place), text: "Lugares"),
              new Tab(icon: new Icon(Icons.help), text: "Acerca de"),
            ]),
          ),
          drawer: DrawerScreen(),
          body: new TabBarView(children: [
            new InicioTabs(),
            new Text("Hola"),
            new Text("Hola"),
            new Text("Hola")
          ]),
        ));
    return new MaterialApp(
      title: "Tabs con Flutter",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: tabController,
    );
  }
}
 */
