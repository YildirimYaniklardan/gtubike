import 'package:flutter/material.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:gtu_bike/constants.dart';
import 'package:gtu_bike/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'resetPassword_screen';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>{



  @override
  Widget build(BuildContext context) {

  String _email;
  bool showSpinner = false;
              
  return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
      inAsyncCall: showSpinner,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 250.0),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: SingleChildScrollView()),
              
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Email'),
              ),

              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              
              RoundedButton(
                  title: "Şifre Yenileme Maili'ni Gönder",
              
                  colour: Colors.lightBlue,

                  
                  onPressed: () async {
                    try{   
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.orangeAccent,
                      content: Text(
                        "Şifre Yenileme Email'i Yollandı",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ));
                  }
                  catch(e){}
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
            ],
          ),
        ),
      ),
    );
   
    
  }}

