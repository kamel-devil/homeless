import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mediLab/screens/auth/MLLoginScreen.dart';
import 'mediLab/screens/home/MLDashboardScreen.dart';
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

  Future check() async {
    return Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.denied) {
        return Geolocator.requestPermission();
      } else {
        return true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    check();
    return GetMaterialApp(
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'Homeless',
      theme: ThemeData(
          fontFamily: 'Amiri',
          primarySwatch: Colors.blue,
          textTheme: TextTheme(titleMedium: GoogleFonts.abel())),
      home: FirebaseAuth.instance.currentUser != null
          ? const MLDashboardScreen()
          : const MLLoginScreen(),
      // home: ApplyFromSite()
    );
  }
}
