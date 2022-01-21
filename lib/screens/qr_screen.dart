import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/smtp_server.dart';
import 'changePassword_screen.dart';
import 'Login_screen.dart';
import 'package:gtu_bike/screens/changePhone_screen.dart';
import 'package:mailer/mailer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

String rentalStartDate = "---";
String rentalFinshDate = "---";
String bikeCounter = "";
String gecikmeMesaji = "Kiralamış olduğunuz bisikletin teslim tarihi geçmiştir. En kısa sürede bisikleti teslim etmeniz gerekmektedir.";
String username = 'gtubike3@gmail.com';
String password = '2021plus.';
bool mailGonderildiMi = false;

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

updateRequest() async {

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

    cf.doc(documentID).update({'kiraTalebi': 'var'});

}

Future sendEmail() async{

  final smtpServer = gmail(username, password);
  FirebaseAuth auth = FirebaseAuth.instance;

    User user = auth.currentUser;

  final message = Message()
    ..from = Address(username, 'GTÜ Bisiklet Yönetim Sistemi')
    ..recipients.add(user.email)
    ..subject = 'GTU Bisiklet Kiralama Gecikme Bildirimi'
    ..text = gecikmeMesaji;
  
  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

}

getData() async{

    String _mail = (await FirebaseAuth.instance.currentUser.email);

    return await FirebaseFirestore.instance
    .collection('kullanicilar')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          
          if(_mail == doc["email"]){
            rentalStartDate = doc["kiraBaslangici"];
            rentalFinshDate = doc["kiraBitisTarihi"];
            bikeCounter = doc["kiralananBisikletSayisi"];
          }
        });    
    });
}

class QrScreen extends StatefulWidget{
  static const String id = 'qr_screen';
  @override
  _QrCodeState createState() => _QrCodeState();
}


class _QrCodeState extends State<QrScreen>{

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded');
    

  String _data="";
  Map<String, dynamic> data;
  String a;
  bool showSpinner = false;
  
  
  _scan() async{
    await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.BARCODE).then((value) => setState(()=>_data = value));
    update(_data);
    updateRequest();
  }
  
  
  @override
  
  Widget build(BuildContext context){
    
    DateTime timeBackPressed = DateTime.now();
   /* 
    FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){},
      future: getData(),
    );*/

    

    FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else{
                   return Center( // here only return is missing
                      child: Text(snapshot.data['email'])
                    );
                  }
                }else if (snapshot.hasError){
                  Text('no data');
                }
                  return CircularProgressIndicator();
                },
              );

    getData();
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print(rentalStartDate);
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

  //getData();
/*
    print("AAAAAAAAAAAAAAAAAAAAAAAAAA   ");
    print(rentalStartDate.substring(0,2));
    print("   AAAAAAAAAAAAAAAAAAAAAAAAAA");

    if(rentalStartDate != null && rentalFinshDate!= null && rentalStartDate != "---"  && rentalFinshDate != "---" ){
      if(mailGonderildiMi == false && rentalStartDate.substring(0,1) == rentalFinshDate.substring(0,1) && rentalStartDate.substring(1,2) == rentalFinshDate.substring(1,2)){
      sendEmail();
      mailGonderildiMi = true;
      }
    }
    */
    //sendEmail();
    
    
    return WillPopScope(
      
    onWillPop: () async {
      final difference =DateTime.now().difference(timeBackPressed);
      final isExitWarning = difference >= Duration(seconds: 2);
      timeBackPressed = DateTime.now();

      if(isExitWarning){
        return false;
      }
      else{
        return true;
      }
    },
    
    
    child: Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 50),
        child:Column(
        
      
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
  
      children: [
        
        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
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

        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        
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
              title: 'TELEFON NUMARASI DEĞİŞİKLİĞİ',
              colour: Colors.blueAccent[700],

              onPressed: () {
                Navigator.pushNamed(context, ChangePhoneScreen.id);
              },  
        ),

        RoundedButton(
              title: 'ÇIKIŞ',
              colour: Colors.blueAccent[700],

              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              },  
        ),

        
        
        
      ],)
    ),
      )
    ),
    );
  }
}
