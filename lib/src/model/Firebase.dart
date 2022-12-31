import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/src/model/Data.dart';
import 'package:firebase_test/src/model/Records.dart';

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
      'Value_Array_number': data,
      'Sequence': sequence
    });
  }

  static Stream<List<Records>> readRecords() => FirebaseFirestore.instance
      .collection("Records")
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            Records record = Records.fromJson(doc.data());
            record.name = doc.reference.id;
            return record;
          }).toList());

  static Stream<List<Data>> readData() =>
      FirebaseFirestore.instance.collection('Data').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Data.fromJson(doc.data());
        }).toList();
      });
}
