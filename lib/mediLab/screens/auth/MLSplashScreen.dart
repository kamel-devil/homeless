import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/MLImage.dart';
import 'MLWalkThroughScreen.dart';


class MLSplashScreen extends StatefulWidget {
  @override
  _MLSplashScreenState createState() => _MLSplashScreenState();
}

class _MLSplashScreenState extends State<MLSplashScreen> {
  @override
  void initState() {
    super.initState();
    //
    init();
  }

  Future<void> init() async {
    await 3.seconds.delay;
    finish(context);
    MLWalkThroughScreen().launch(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Image.asset(
          ml_ic_medilab_logo!,
          height: 300,
          width: 150,
          fit: BoxFit.fill,
        ).center(),
      ),
    );
  }
}
