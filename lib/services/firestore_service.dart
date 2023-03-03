import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tv_indonesia/models/chanel_model.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ChanelModel>> getAllItem() {
    // _db
    //     .collection("items")
    //     .where("succes", isEqualTo: true)
    //     .orderBy("succes", descending: true)
    //     .orderBy("name", descending: true)
    //     .get()
    //     .then((value) => {print(value)});
    return _db
        .collection('items')
        .where("succes", isEqualTo: true)
        .snapshots()
        .map(
      (snapshots) {
        // snapshots.docChanges.forEach((docChange) {
        //   final data = docChange.doc.data() as Map;
        // });

        return snapshots.docs.map((document) {
          print(document.data()["succes"].runtimeType);
          Map<String, dynamic> data = {
            "id": document.id,
            "name": document.data()["name"],
            "logo": document.data()["logo"],
            "succes": document.data()["succes"],
            "url": document.data()["url"],
          };
          return ChanelModel.fromJson(data);
        }).toList();
      },
    );
  }
}
