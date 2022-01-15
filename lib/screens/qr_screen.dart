import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gtu_bike/screens/welcome_screen.dart';
import 'changePassword_screen.dart';

String rentalStartDate = "";
String rentalFinshDate = "";
String bikeCounter = "";


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

getRentalDate(String a)  async {

    FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic> data;
    User user = auth.currentUser;

    CollectionReference cf = FirebaseFirestore.instance.collection('kullanicilar');
    var documentID;
    var collection = FirebaseFirestore.instance.collection('kullanicilar');
    
    var querySnapshots = await collection.get();
                  
    for (var snapshot in querySnapshots.docs) {
      if(snapshot.data().entries.last.toString().contains(user.email)){
        documentID = snapshot.id;
         
        data = snapshot.data() as Map<String, dynamic>;   
        a = data['kiraBaslangici']; 
                        
      }                              
    }

    cf.doc(documentID).update({'qrCode': data});

    
    
    print("YYYYYYYYYYYYYYY"); 
    print(a); 
    print("YYYYYYYYYYYYYYY"); 

    return data;
    //cf.doc(documentID).get().then((value) => snap);
    
}


class QrScreen extends StatefulWidget{
  static const String id = 'qr_screen';
  @override
  _QrCodeState createState() => _QrCodeState();
}


class _QrCodeState extends State<QrScreen>{
  String _data="";
  Map<String, dynamic> data;
  String a;
  

  
  
  _scan() async{

    await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.BARCODE).then((value) => setState(()=>_data = value));
    update(_data);
  }
  
  @override
  
  Widget build(BuildContext context){

    


    String documentID;
    FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic> data;
    User user = auth.currentUser;
    TextEditingController _controller = new TextEditingController();
    
    FirebaseFirestore.instance
    .collection('kullanicilar')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          
          if(user.email == doc["email"]){
            rentalStartDate = doc["kiraBaslangici"];
            rentalFinshDate = doc["kiraBitisTarihi"];
            bikeCounter = doc["kiralananBisikletSayisi"];
            print("DOCUMENT ID BURADA : " + documentID);
            rentalStartDate=documentID;
          }
        });    
    });

    print("WWWWWWWWWWWWWWWWWWWWWWWWW");
    print("DOCUMENT ID 2 BURADA : ");
    print(rentalStartDate);

    
    
    
    return Scaffold(

      
      
      
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 50),
        child:Column(
        
      
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
  
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text(
          'Şimdiye Kadar Kiralanan Bisiklet Sayısı ',   
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          bikeCounter,      
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          'Bisiklet Kiralama Başlangıç Tarihi',   
          textAlign: TextAlign.center,   
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          
          rentalStartDate,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          'Bisiklet Kiralama Bitiş Tarihi', 
          textAlign: TextAlign.center,     
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          rentalFinshDate,      
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),

        
        RoundedButton(
              title: 'BİSİKLET KİRALA',
              colour: Colors.blueAccent[700],
              onPressed: _scan,         
        ),

        RoundedButton(
              title: 'ŞİFRE DEĞİŞİKLİĞİ',
              colour: Colors.blueAccent[700],

              onPressed: () {
                Navigator.pushNamed(context, ChangePasswordScreen.id);
              },  
        ),

        RoundedButton(
              title: 'ÇIKIŞ',
              colour: Colors.blueAccent[700],

              onPressed: () {
                Navigator.pushNamed(context, WelcomeScreen.id);
              },  
        ),

        
        
        
      ],)
    ),
    );
  }
}
