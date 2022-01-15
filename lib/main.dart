import 'package:gtu_bike/screens/changePassword_screen.dart';
import 'package:gtu_bike/screens/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:gtu_bike/screens/welcome_screen.dart';
import 'package:gtu_bike/screens/login_screen.dart';
import 'package:gtu_bike/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'package:gtu_bike/screens/chat_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        QrScreen.id: (context) => QrScreen(),
        ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
      },
    );
  }
}
