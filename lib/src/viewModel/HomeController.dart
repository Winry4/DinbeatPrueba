import 'dart:io';

import 'package:firebase_test/src/model/FirebaseRead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:string_splitter/string_splitter.dart';
import 'package:file_picker/file_picker.dart';

class HomeController extends ChangeNotifier {
  int numberDoc = 0;

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
      print("stringParts " + stringParts.length.toString());

      numberDoc = numberDoc + 1;
      String docName = "newDocumentRecord_$numberDoc";

      print("docName " + docName);
      Firebase.sendFirebaseRecord(docName, stringParts.length, uid);

      for (int i = 0; i < stringParts.length; i++) {
        String dataName = "newDocumentData_$numberDoc" "_$i";
        Firebase.sendFirebaseData(
            docName, dataName, stringParts.elementAt(i).replaceAll("[", ""), i);
      }
    } else {
      // User canceled the picker
    }
  }

  graphics(context) {}
}
