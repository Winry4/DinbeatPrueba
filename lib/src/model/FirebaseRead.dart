import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {
  static void sendFirebaseRecord(docName, totalSegments) {
    FirebaseFirestore.instance.collection("Records").doc(docName).set(
        {'UuidUser': "", 'Totalsegments': totalSegments, 'Timestamp:': 20});
  }

  static void sendFirebaseData(docName, dataName, data, sequence) {
    FirebaseFirestore.instance.collection('Data').doc(dataName).set({
      'newdocument_record': docName,
      'Value_Array_number]': data,
      'Sequence': sequence
    });
  }
}
