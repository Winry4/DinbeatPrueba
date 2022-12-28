import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/utils/wave_cliper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/App_theme.dart';
import 'package:string_splitter/string_splitter.dart';

import '../model/FirebaseRead.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int numberDoc = 0;
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double waveSection = totalHeight / 2.5;

    return Container(
        color: Colors.white,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: waveSection,
                  child: ClipPath(
                      clipper: WaveClipper(),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.blue, Colors.teal])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            SizedBox(
                              height: 64,
                              width: 64,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(
                                "Dinbeat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "MoonlightsOnTheBeach",
                                  fontWeight: FontWeight.normal,
                                ),
                                textScaleFactor: 4,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: subirArchivo,
                        child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 3))
                            ]),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text("SUBIR ARCHIVO",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Icon(Icons.upload_file)
                                  ],
                                )),
                              ),
                            ))),
                    GestureDetector(
                        onTap: graficar,
                        child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 3))
                            ]),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text("GRAFICAR",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Icon(Icons.auto_graph_rounded)
                                  ],
                                )),
                              ),
                            )))
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(onPressed: logout, child: Text("Sign out"))
              ],
            )));
  }

  void graficar() {}

  Future<void> subirArchivo() async {
    print("subirArchivo");
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String data = await file.readAsString();

      final stringParts = StringSplitter.split(
        data,
        splitters: [']'],
        trimParts: true,
      );
      print("stringParts " + stringParts.length.toString());

      numberDoc = numberDoc + 1;
      String docName = "newDocumentRecord_$numberDoc";

      print("docName " + docName);
      Firebase.sendFirebaseRecord(docName, stringParts.length);

      for (int i = 0; i < stringParts.length; i++) {
        String dataName = "newDocumentData_$numberDoc" "_$i";
        Firebase.sendFirebaseData(
            docName, dataName, stringParts.elementAt(i).replaceAll("[", ""), i);
      }
    } else {
      // User canceled the picker
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
