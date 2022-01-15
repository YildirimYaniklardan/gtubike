import 'package:gtu_bike/database/database.dart';
import 'package:flutter/material.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:gtu_bike/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  String phoneNumber;
  int rentCounter = 0;

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
              //////////////////////////////////////////////////////////////////
              TextField(
                
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phoneNumber = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Telefon Numarası'),
              ),
              SizedBox(
                height: 8.0,
              ),
              //////////////////////////////////////////////////////////////////
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
                        "qrCode": "-",
                        "kiralananBisikletSayisi": "0",
                        "kiraTalebi": "yok",
                        "kiraBaslangici":"-",
                        "kiraBitisTarihi":"-",
                      };

                      database.addData(kullaniciBilgileri).then((result){
                        Navigator.pop(context);
                      });
                  
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
