import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/src/model/DataGraphic.dart';
import 'package:firebase_test/src/viewModel/HomeController.dart';
import 'package:firebase_test/utils/wave_cliper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  String uid;

  Home({Key? key, required this.uid}) : super(key: key);
  @override
  _HomeState createState() => _HomeState(uid: this.uid);
}

class _HomeState extends State<Home> {
  String uid;
  _HomeState({required this.uid});
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
                        onTap: () {
                          subirArchivo(context);
                        },
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

  void graficar() {
    Provider.of<HomeController>(context, listen: false).graphicsData(context);
  }

  void subirArchivo(BuildContext context) {
    Provider.of<HomeController>(context, listen: false)
        .uploadFile(context, uid);
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
