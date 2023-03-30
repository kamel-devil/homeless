import 'package:flutter/material.dart';
import 'package:homeless/mediLab/screens/auth/MLLoginScreen.dart';


import 'package:provider/provider.dart';
import '../../controller/controller.dart';

import '../map/map.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapPageController>(builder: (context, value, child) {
      return FutureBuilder(
        future: value.check(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('data${snapshot.data}');
              return MLLoginScreen();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
      );
    });
  }
}
