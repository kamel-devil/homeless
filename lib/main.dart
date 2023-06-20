import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mediLab/screens/auth/MLLoginScreen.dart';
import 'mediLab/screens/home/MLDashboardScreen.dart';
import 'mediLab/screens/nicu_chat/screens/auth/login_screen.dart';
import 'mediLab/store/AppStore.dart';

AppStore appStore = AppStore();
final navigatorKey = GlobalKey<NavigatorState>();
late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'Homeless',
      theme: ThemeData(
          fontFamily: 'Amiri',
          primarySwatch: Colors.blue,
          textTheme: TextTheme(titleMedium: GoogleFonts.abel())),
      home:
      FirebaseAuth.instance.currentUser !=null ?const MLDashboardScreen():
      const MLLoginScreen(),
    );
  }
}
