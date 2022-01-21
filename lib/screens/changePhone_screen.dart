import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gtu_bike/constants.dart';
import 'package:gtu_bike/screens/qr_screen.dart';

updatePhone(String data) async {


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

    cf.doc(documentID).update({'phoneNumber': data});
    
}

class ChangePhoneScreen extends StatefulWidget{
  static const String id = 'changePhone_screen';
  @override
  _ChangePhoneState createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhoneScreen>{
  
  String newPhone1, newPhone2;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 100),
        child:Column(
        
      
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        TextField(
        obscureText: true,
        textAlign: TextAlign.center,

        onChanged: (value) {
          newPhone1 = value;
        },
        decoration: kTextFieldDecoration.copyWith(
            hintText: 'Yeni Telefon Numarası'),
        ),
        SizedBox(
          height: 8.0,
        ),

        TextField(
        obscureText: true,
        textAlign: TextAlign.center,

        onChanged: (value) {
          newPhone2 = value;
        },
        decoration: kTextFieldDecoration.copyWith(
            hintText: 'Yeni Telefon Numarası'),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        RoundedButton(
              title: 'Telefon Numarasını Değiştir',
              
              //colour: Colors.lightBlueAccent,
              colour: Colors.blueAccent[700],
              onPressed: () {
                if(newPhone1==newPhone2){
                  updatePhone(newPhone1);

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text('Telefon numaranız değiştirildi.'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, QrScreen.id);
                            },
                            child: Text('Tamam'))
                      ],
                    ),
                  );

                  
                }
                else{
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('HATA'),
                      content: Text('Girdiğiniz numaralar aynı değil'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Geri'))
                      ],
                    ),
                  );
                }
                
              },
            ),
        
      ],)
      
    ),
    

        
      
      );
      
    

    

  }
}
