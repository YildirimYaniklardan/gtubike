import 'package:flutter/material.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:gtu_bike/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gtu_bike/screens/welcome_screen.dart';
import 'package:gtu_bike/screens/resetPassword_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'qr_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
    onWillPop: () async {
      Navigator.pushNamed(context, WelcomeScreen.id);
      return true;
    },

    child: Scaffold(
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
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
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
                height: 24.0,
              ),
              RoundedButton(
                title: 'Giriş Yap',
                colour: Colors.lightBlueAccent,
                onPressed: () async {
                  

                  setState(() {
                    showSpinner = true;

                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, QrScreen.id);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                    
                    
                  } catch (e) {
                    showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('HATA'),
                      content: Text('Kullanıcı adı veya şifre hatalı.'),
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

                },
              ),


              RoundedButton(
                title: 'Şifremi Unuttum',
                colour: Colors.lightBlueAccent,
                onPressed: () async {

                  Navigator.pushNamed(context, ResetPasswordScreen.id);
                  /*
                  try{   burası şifre yenileme sayfasına gelecek.
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.orangeAccent,
                      content: Text(
                        "Şifre Yenileme Email'i Yollandı",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ));
                  }
                  catch(e){}*/

                },
              ),
            ],
          ),
        ),
      ),
    ),
    );
    
  }
}




