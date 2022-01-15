import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gtu_bike/constants.dart';
import 'package:gtu_bike/screens/qr_screen.dart';

updatePass(String data) async {


    FirebaseAuth auth = FirebaseAuth.instance;

    User user = auth.currentUser; 
    user.updatePassword(data);


    CollectionReference cf = FirebaseFirestore.instance.collection('kullanicilar');
    var documentID;
    var collection = FirebaseFirestore.instance.collection('kullanicilar');
    
    var querySnapshots = await collection.get();
                  
    for (var snapshot in querySnapshots.docs) {
      if(snapshot.data().entries.last.toString().contains(user.email)){
        documentID = snapshot.id;                      
      }                              
    }

    cf.doc(documentID).update({'password': data});
    
}

class ChangePasswordScreen extends StatefulWidget{
  static const String id = 'changePassword_screen';
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen>{
  
  String newPassword1, newPassword2;

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
          newPassword1 = value;
        },
        decoration: kTextFieldDecoration.copyWith(
            hintText: 'Yeni Şifre'),
        ),
        SizedBox(
          height: 8.0,
        ),

        TextField(
        obscureText: true,
        textAlign: TextAlign.center,

        onChanged: (value) {
          newPassword2 = value;
        },
        decoration: kTextFieldDecoration.copyWith(
            hintText: 'Yeni Şifre'),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        RoundedButton(
              title: 'Şifreyi Değiştir',
              
              //colour: Colors.lightBlueAccent,
              colour: Colors.blueAccent[700],
              onPressed: () {
                if(newPassword1==newPassword2){
                  updatePass(newPassword1);

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text('Şifreniz değiştirildi.'),
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
                      content: Text('Girdiğiniz şifreler aynı değil'),
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
