import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mediLab/screens/auth/MLSplashScreen.dart';
import 'mediLab/screens/home/MLDashboardScreen.dart';
import 'mediLab/screens/order/applyfromsite.dart';
import 'mediLab/screens/order/order.dart';
import 'mediLab/screens/sponsorship_conditions/sponsorship_conditions.dart';
import 'mediLab/store/AppStore.dart';

AppStore appStore = AppStore();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: MLDashboardScreen(),
    );
  }
}
