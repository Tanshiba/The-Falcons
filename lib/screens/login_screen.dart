import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:my_multivender_ecommerce_app/screens/main_screen.dart';
// import 'package:shop_app_vendor/screens/landing_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routName = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SignInScreen(

              providerConfigs: [
              EmailProviderConfiguration(),
              // GoogleProviderConfiguration(
              //   // firebase app id  =>
              //    clientId: '1:1087344232499:android:1f5c2e6936f60b44443b46'
              //   ),  
              // PhoneProviderConfiguration(),
            ]);
          }
          return const MainScreen();
     }
    );
  }
}
