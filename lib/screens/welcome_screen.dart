import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:gtu_bike/screens/contract_screen.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;



  @override
  Widget build(BuildContext context) {

    var now = DateTime.now();
    print(now.toString());


    return WillPopScope(
      onWillPop: () async {
        
        SystemNavigator.pop();
      return true;
    },
    
    child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  'GTU Bisiklet Kiralama Sistemi',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Giriş Yap',
              
              //colour: Colors.lightBlueAccent,
              colour: Colors.blueGrey[900],
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            RoundedButton(
              title: 'Kaydol',
              colour: Colors.blueAccent[700],
              onPressed: () {
                Navigator.pushNamed(context, ContractScreen.id);
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}
