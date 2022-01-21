import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase{
  Future <void> addData (kullaniciBilgileri, String mail) async{
    var db = FirebaseFirestore.instance.collection("kullanicilar");

    db.doc(mail).set(kullaniciBilgileri);
    /*FirebaseFirestore.instance.collection("kullanicilar").add(kullaniciBilgileri).catchError((hata){
      Fluttertoast.showToast(msg: "Hata" + hata.toString());
    });*/
  }

}