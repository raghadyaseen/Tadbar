import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart'; // استيراد حزمة firebase_core

import 'onboarding/splash_screen.dart'; // شاشة البداية الخاصة بك
//import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تأكيد تهيئة الفلاتر قبل التشغيل
  // await Firebase.initializeApp(); // تهيئة Firebase

  runApp(const MyApp()); // تشغيل التطبيق بعد التهيئة
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tadbar',
        debugShowCheckedModeBanner: false,
        //     ),
        // theme: ThemeData(
        //  textTheme: GoogleFonts.latoTextTheme(),
        //),
        home: SplashScreen());
  }
}
