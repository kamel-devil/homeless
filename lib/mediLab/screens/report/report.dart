import 'dart:io';
import 'dart:math' show asin, cos, pi, sin, sqrt;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controller/controller.dart';
import '../house_info/hospital_info.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  File? imageFile;
  MapPageController con = Get.put(MapPageController());
  String id = '';
  String email1 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24)
                .onTap(() {}),
            Row(
              children: [
                Text('رجوع',
                    style: boldTextStyle(size: 24, color: Colors.white)),
                8.width,
              ],
            ),
          ],
        ).paddingAll(16.0),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent)),
              child: imageFile == null
                  ? const Icon(
                      Icons.image,
                      color: Colors.redAccent,
                    )
                  : Image.file(imageFile!),
            ),
            16.height,
            imageFile == null
                ? Column(
                    children: [
                      12.height,
                      GestureDetector(
                        onTap: () => openCamera(),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.black12.withOpacity(.2),
                                    offset: const Offset(2, 2))
                              ],
                              borderRadius: BorderRadius.circular(20).copyWith(
                                  bottomRight: const Radius.circular(0)),
                              gradient: LinearGradient(colors: [
                                Colors.redAccent.shade200,
                                Colors.red.shade900
                              ])),
                          child: Text('الكاميرا',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
                      14.height,
                      GestureDetector(
                        onTap: () => openGallery(),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.black12.withOpacity(.2),
                                    offset: const Offset(2, 2))
                              ],
                              borderRadius: BorderRadius.circular(20).copyWith(
                                  bottomRight: const Radius.circular(0)),
                              gradient: LinearGradient(colors: [
                                Colors.redAccent.shade200,
                                Colors.red.shade900
                              ])),
                          child: Text('المعرض',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () async {
                      con.getCurrentLocation().then((value) async {
                        await findMinDistanceFromFirebase(
                                value!.latitude, value.longitude)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HospitalInfo(
                                  uid: id,
                                  email: email1,
                                  report: true,
                                  file: imageFile,
                                ),
                              ));
                        });
                      });
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.black12.withOpacity(.2),
                                offset: const Offset(2, 2))
                          ],
                          borderRadius: BorderRadius.circular(20)
                              .copyWith(bottomRight: const Radius.circular(0)),
                          gradient: LinearGradient(colors: [
                            Colors.redAccent.shade200,
                            Colors.red.shade900
                          ])),
                      child: Text('متابعه',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 20,
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

// Function to calculate the distance between two coordinates using the Haversine formula
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final num c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * (pi / 180);
  }

// Function to find the minimum distance between fetched coordinates and a current location
  Future<double> findMinDistanceFromFirebase(
      double currentLat, double currentLon) async {
    double minDistance = double.infinity;

    try {
      final collectionReference = FirebaseFirestore.instance.collection('home');
      final snapshot = await collectionReference.get();

      for (final document in snapshot.docs) {
        final coordinate = document.data();
        final double lat = double.parse(coordinate['late']);
        final double lon = double.parse(coordinate['long']);
        final String ref = coordinate['uid'];
        final String email = coordinate['email'];
        final double distance =
            calculateDistance(currentLat, currentLon, lat, lon);
        if (distance < minDistance) {
          minDistance = distance;
          id = ref;
          email1 = email;
        }
      }
    } catch (e) {
      print('Error fetching coordinates from Firebase: $e');
    }
    print('0000000000000000000000000000000000');
    print(minDistance);
    return minDistance;
  }

  Future openGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        imageFile = imageTemporary;
      });
    } catch (error) {
      print("error: $error");
    }
  }

  Future openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        imageFile = imageTemporary;
      });
    } catch (error) {
      print("error: $error");
    }
  }
}
