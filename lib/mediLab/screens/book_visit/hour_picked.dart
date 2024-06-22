import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controller/visitController.dart';
import '../../utils/MLColors.dart';
import '../home/MLDashboardScreen.dart';

class Cupert extends StatefulWidget {
  const Cupert({super.key});

  @override
  _CupertState createState() => _CupertState();
}

class _CupertState extends State<Cupert> {
  Duration? value = const Duration(hours: 00, minutes: 00);
  VisitController controller = Get.put(VisitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'اختار التوقيت',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
            ),
            15.height,
            Center(
              child: Text(
                value!
                    .toString()
                    .split('.')
                    .first,
                style:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              onTimerDurationChanged: (value) {
                setState(() {
                  this.value = value;
                });
              },
            ),
            25.height,
            AppButton(
              height: 50,
              width: double.infinity,
              color: mlColorDarkBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("انهاء", style: boldTextStyle(color: white)),
                  8.width,
                  const Icon(Icons.arrow_forward_ios,
                      color: whiteColor, size: 12),
                ],
              ),
              onTap: () {
                controller.updateTime(value!
                    .toString()
                    .split('.')
                    .first);
                addBookVisit();
                const MLDashboardScreen().launch(context);
              },
            ).paddingOnly(right: 16, left: 16, bottom: 16)
          ],
        ),
      ),
    );
  }

  void addBookVisit() async {
    await FirebaseFirestore.instance.collection('visit').add({
      'home': controller.visitData['name'],
      'phone': controller.visitData['phone'],
      'address': controller.visitData['address'],
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'time': controller.time,
      'date': controller.date,
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('visit')
        .add({
      'home': controller.visitData['name'],
      'phone': controller.visitData['phone'],
      'address': controller.visitData['address'],
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'time': controller.time,
      'date': controller.date,
    });
  }
}
