import 'package:gtu_bike/database/database.dart';
import 'package:flutter/material.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:gtu_bike/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:gtu_bike/screens/login_screen.dart';



class RegistrationScreen extends StatefulWidget {
  
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool value = false;
  bool showSpinner = false;
  String email;
  String password;
  String name;
  String surname;
  String studentNumber;
  String idNumber;
  String phoneNumber;
  String personelOgrenci = "Öğrenci";

  DataBase database = new DataBase();

  @override
  Widget build(BuildContext context) {

    Map <String, String> kullaniciBilgileri;

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
              Expanded(child: SingleChildScrollView()),
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
              Text(
                          'Personelseniz Aşağıdaki Kutuyu İşaretleyin',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17.0),
                        ), //Text
              Checkbox(
                          
                          value: value,
                          onChanged: (value) {
                            setState(() {
                              this.value = value;
                            });
                            if (value == true){
                              personelOgrenci = "Personel";
                            }
                            else{personelOgrenci = "Öğrenci";}
                          },
                        ), //Checkbox
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
                      kullaniciBilgileri = {     //Database'e eklenecek veriler

                        "name":name,
                        "surname":surname,
                        "studentNumber":studentNumber,
                        "idNumber":idNumber,
                        "email": email, 
                        "password": password,
                        "phoneNumber": phoneNumber,
                        "ogrenciMiPersonelMi": personelOgrenci,
                        "qrCode": "-1",
                        "kiralananBisikletSayisi": "0",
                        "kiraTalebi": "yok",
                        "kiraBaslangici":"-",
                        "kiraBitisTarihi":"-",
                        "not": "-",
                        "bisikletVarmi":"yok",      
                        "karalistedeMi":"hayır",               
                      };                                 
                  
                    }
                    

                  if(name != null && surname != null && studentNumber != null && idNumber != null && email != null && password != null && phoneNumber != null){
                    database.addData(kullaniciBilgileri, email).then((result){
                        Navigator.pushNamed(context, LoginScreen.id);
                      });
                  }
                  else{
                    showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('HATA'),
                      content: Text('Bütün alanlar doldurulmalı.'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Geri'))
                      ],
                    ),
                  );
                  setState(() {
                      showSpinner = false;
                    });
                  }
                    

                    
                  } catch (e) {
                    if(name == null || surname == null || studentNumber == null || idNumber == null || email == null || password == null || phoneNumber == null){
                      showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('HATA'),
                      content: Text('Bütün alanlar doldurulmalı.'),
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

                    else{
                      showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('HATA'),
                      content: Text('Hatalı Giriş.'),
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
                    
                  setState(() {
                      showSpinner = false;
                    });
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
