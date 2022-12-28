import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {
  static void sendFirebaseRecord(docName, totalSegments, uid) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    FirebaseFirestore.instance.collection("Records").doc(docName).set({
      'UuidUser': uid,
      'Totalsegments': totalSegments,
      'Timestamp:': timestamp
    });
  }

  static void sendFirebaseData(docName, dataName, data, sequence) {
    FirebaseFirestore.instance.collection('Data').doc(dataName).set({
      'newdocument_record': docName,
      'Value_Array_number]': data,
      'Sequence': sequence
    });
  }
}
