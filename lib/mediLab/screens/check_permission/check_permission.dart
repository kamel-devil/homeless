import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';

import '../auth/MLLoginScreen.dart';
import '../map/map.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  MapPageController controller = Get.put(MapPageController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.check(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('data${snapshot.data}');
            return MapPage();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
