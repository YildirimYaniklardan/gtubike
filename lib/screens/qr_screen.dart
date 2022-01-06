import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_date/dart_date.dart';

update(String data) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    
    
    User user = auth.currentUser;

    CollectionReference cf = FirebaseFirestore.instance.collection('kullanicilar');
    var documentID;
    var collection = FirebaseFirestore.instance.collection('kullanicilar');
    
    var querySnapshots = await collection.get();
                  
    for (var snapshot in querySnapshots.docs) {
      if(snapshot.data().entries.last.toString().contains(user.email)){
        documentID = snapshot.id;                      
      }                              
    }

    cf.doc(documentID).update({'qrCode': data});

    
}


class QrScreen extends StatefulWidget{
  static const String id = 'qr_screen';
  @override
  _QrCodeState createState() => _QrCodeState();
}


class _QrCodeState extends State<QrScreen>{
  String _data="";
  
  _scan() async{

    await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.BARCODE).then((value) => setState(()=>_data = value));
    update(_data);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
      
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      
      children: [
        
        RoundedButton(
              title: 'LÜTFEN BİSİKLET ÜZERİNDEKİ BARKODU OKUTUN',
              colour: Colors.blueAccent[700],
              onPressed: _scan,
              
            ),

        
        Text(_data),
        
        
      ],)
    );
  }
}
