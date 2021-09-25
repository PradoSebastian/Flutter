import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NuevoContacto extends StatefulWidget {
  @override
  _NuevoContactoState createState() => _NuevoContactoState();
}

class _NuevoContactoState extends State<NuevoContacto> {
  TextEditingController firstNameContr;
  TextEditingController lastNameContr;
  TextEditingController telefonoContr;

  File imageFile;

  Country selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("57");
  String countryCode = "+57";

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
    firstNameContr = TextEditingController();
    lastNameContr = TextEditingController();
    telefonoContr = TextEditingController();
    super.initState();
  }

  Widget buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.blue, width: 1),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("+${country.phoneCode}"),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("${country.name}"),
          ),
          Spacer(),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  void openFilteredCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.blue),
          child: CountryPickerDialog(
              titlePadding: EdgeInsets.all(8.0),
              searchCursorColor: Colors.blueAccent,
              searchInputDecoration: InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: Text('Select your phone code'),
              onValuePicked: (Country country) => setState(() {
                    selectedFilteredDialogCountry = country;
                    countryCode = country.phoneCode;
                  }),
              itemBuilder: buildDialogItem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "New Contact",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leading: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 20),
          child: InkWell(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
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
      body: Padding(
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
                  child: Column(
                    children: [
                      TextField(
                        controller: firstNameContr,
                        decoration: InputDecoration(
                            hintText: "First Name",
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(top: 10, bottom: 10)),
                      ),
                      TextField(
                        controller: lastNameContr,
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(top: 10, bottom: 10)),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            Container(
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        child: ListTile(
                            onTap: openFilteredCountryPickerDialog,
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CountryPickerUtils.getDefaultFlagImage(
                                      selectedFilteredDialogCountry),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                        "+${selectedFilteredDialogCountry.phoneCode}"),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_drop_down)
                                ]))),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextField(
                        controller: telefonoContr,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Número celular...",
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(top: 10, bottom: 10)),
                      ),
                    ))
                  ],
                ),
                margin: EdgeInsets.only(top: 30))
          ],
        ),
      ),
    );
  }
}
