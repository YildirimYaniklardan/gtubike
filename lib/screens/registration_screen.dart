import 'package:flash_chat/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String name;
  String surname;
  String studentNumber;
  String idNumber;

  DataBase database = new DataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 160.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              ////////////////////////////////////////////////////////////////////
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'İsim'),
              ),
              SizedBox(
                height: 8.0,
              ),
              //////////////////////////////////////////////////////////////////
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  surname = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Soyisim'),
              ),
              SizedBox(
                height: 8.0,
              ),
              //////////////////////////////////////////////////////////////////
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              //////////////////////////////////////////////////////////////////
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Şifre'),
              ),
              SizedBox(
                height: 8.0,
              ),
              //////////////////////////////////////////////////////////////////
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  studentNumber = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Öğrenci Numarası'),
              ),
              SizedBox(
                height: 8.0,
              ),
              //////////////////////////////////////////////////////////////////
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  idNumber = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Kimlik Numarası'),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedButton(
                title: 'Kaydol',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);

                    if (newUser != null) {
                      Map <String, String> kullaniciBilgileri = {     //Database'e eklenecek veriler

                        "name":name,
                        "surname":surname,
                        "studentNumber":studentNumber,
                        "idNumber":idNumber,
                        "email": email, 
                        "password": password,
                      };

                      database.addData(kullaniciBilgileri).then((result){
                        Navigator.pop(context);
                      });


                    //  Navigator.pushNamed(context, ChatScreen.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
