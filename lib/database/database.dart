import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DataBase{
  Future <void> addData (kullaniciBilgileri) async{
    FirebaseFirestore.instance.collection("kullanicilar").add(kullaniciBilgileri).catchError((hata){
      Fluttertoast.showToast(msg: "Hata" + hata.toString());
    });
  }

}