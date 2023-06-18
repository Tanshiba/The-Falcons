import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_multivender_ecommerce_app/providers/cart_provider.dart';
import 'package:my_multivender_ecommerce_app/screens/login_screen.dart';
import 'package:my_multivender_ecommerce_app/screens/main_screen.dart';
import 'package:my_multivender_ecommerce_app/on_boarding_screen.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Lato'),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routName: (context) => const SplashScreen(),
        OnBoardingScreen.boardingRout: (context) => const OnBoardingScreen(),
        MainScreen.routName: (context) => const MainScreen(),
        LoginScreen.routName: (context) => const LoginScreen(),
      },
    );
  }
  
  cartItem() {}
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routName = 'splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final store = GetStorage();
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        // bool? boarding = store.read('onBoarding');
        // boarding == null
        //     ? Navigator.pushReplacementNamed(
        //         context, OnBoardingScreen.boardingRout)
        //     : boarding == true
        //         ?
                 Navigator.pushReplacementNamed(context, LoginScreen.routName);
                // : Navigator.pushReplacementNamed(
                //     context, OnBoardingScreen.boardingRout);
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Image.asset('lib/assets/images/splashcreen.jpg'),
      ),
    );
  }
}

