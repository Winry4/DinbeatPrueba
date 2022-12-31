import 'dart:io';

import 'package:firebase_test/src/model/Firebase.dart';
import 'package:firebase_test/src/view/Graphic.dart';
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

  void graphicsData(context) {
    print("Graphics Data ");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Graphic()),
    );
  }
}
