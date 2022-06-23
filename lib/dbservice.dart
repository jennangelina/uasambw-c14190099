import 'package:c14190099_01/dataclass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference tblLiked = FirebaseFirestore.instance.collection("liked");

class Database {
  static Stream<QuerySnapshot> getAllData() {
    return tblLiked.snapshots();
  }

  static Stream<QuerySnapshot> getData(String judul) {
    if (judul == "")
      return tblLiked.snapshots();
    else
      return tblLiked
      .orderBy("title")
      .startAt([judul]).endAt([judul + '\uf8ff'])
      .snapshots();
  }

  static Future<void> addData({required cBerita item}) async {
    DocumentReference docRef = tblLiked.doc(item.cTitle);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("Data berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required String judulHapus}) async {
    DocumentReference docRef = tblLiked.doc(judulHapus);
    await docRef
        .delete()
        .whenComplete(() => print("Data berhasil dihapus"))
        .catchError((e) => print(e));
  }
}
