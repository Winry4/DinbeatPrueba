import 'dart:io';

import 'package:firebase_test/src/model/Data.dart';
import 'package:firebase_test/src/model/DataGraphic.dart';
import 'package:firebase_test/src/model/Firebase.dart';
import 'package:firebase_test/src/model/Records.dart';
import 'package:firebase_test/src/view/Graphic.dart';
import 'package:flutter/material.dart';
import 'package:string_splitter/string_splitter.dart';
import 'package:file_picker/file_picker.dart';

class HomeController extends ChangeNotifier {
  int numberDoc = 0;

  //Seleccionar y leer fichero. Separar los datos y enviar a Firebase
  uploadFile(context, uid) async {
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

      numberDoc = numberDoc + 1;
      String docName = "newDocumentRecord_$numberDoc";

      Firebase.sendFirebaseRecord(docName, stringParts.length - 1, uid);

      for (int i = 0; i < stringParts.length - 1; i++) {
        String dataName = "newDocumentData_$numberDoc" "_$i";
        Firebase.sendFirebaseData(
            docName, dataName, stringParts.elementAt(i).replaceAll("[", ""), i);
      }
    } else {
      // User canceled the picker
    }
  }

  //Cambiar de pantalla
  void graphicsData(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Graphic()),
    );
  }

  // Leer los Records y coger el último en base al Timestamp
  // Future<Records> getLastRecord() async {
  //   List<Records> listRecords = await Firebase.readRecords().first;
  //   Records last = listRecords.first;
  //   for (int i = 0; i < listRecords.length; i++) {
  //     if (listRecords[i].timestamp > last.timestamp) {
  //       last = listRecords[i];
  //     }
  //   }
  //   return last;
  // }

  // Coger solo los Data pertenecientes al ultimo Record
  // Future<List<DataGraphic>> getData(List<Data> listData) async {
  //   List<Data> listFinal = [];
  //   Records lastRecord = await getLastRecord();
  //   for (int i = 0; i < listData.length; i++) {
  //     if (listData[i].newdocument_record == lastRecord.name) {
  //       listFinal.add(listData[i]);
  //     }
  //   }
  //   List<DataGraphic> listG = getGraphicData(listFinal);
  //   return listG;
  // }

  //  Transformar los datos de Firestore en el formato necesario para la grafica
  List<DataGraphic> getGraphicData(listData) {
    List<DataGraphic> listG = [];
    int x = 0;
    for (int i = 0; i < listData.length; i++) {
      List<String> arrayN = listData[i].value_Array_number.split(", ");
      for (int j = 0; j < arrayN.length; j++) {
        listG.add(DataGraphic(x, int.parse(arrayN[j])));
        x++;
      }
    }

    return listG;
  }
}
