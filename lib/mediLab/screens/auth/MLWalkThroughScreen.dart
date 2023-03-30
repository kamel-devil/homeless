import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


import '../../model/MLWalkThroughData.dart';
import '../../utils/MLColors.dart';
import '../../utils/MLDataProvider.dart';
import '../../utils/MLString.dart';
import 'MLLoginScreen.dart';

class MLWalkThroughScreen extends StatefulWidget {
  static String tag = '/MLWalkThroughScreen';

  @override
  _MLWalkThroughScreenState createState() => _MLWalkThroughScreenState();
}

class _MLWalkThroughScreenState extends State<MLWalkThroughScreen> {
  PageController controller = PageController();

  List<MLWalkThroughData> list = mlWalkThroughDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(mlPrimaryColor, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: boxDecorationWithRoundedCorners(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, Colors.red]),
          ),
          child: Stack(
            children: [
              PageView(
                controller: controller,
                children: list.map((e) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: boxDecorationWithRoundedCorners(
                          boxShape: BoxShape.circle,
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, Colors.red]),
                        ),
                        height: 270,
                        width: 230,
                        child: Image.asset(e.imagePath.validate(), fit: BoxFit.contain),
                      ),
                      48.height,
                      Text(e.title.validate(), style: boldTextStyle(size: 28, color: blackColor)),
                      16.height,
                      Text(e.subtitle.validate(), style: secondaryTextStyle(color: blackColor), textAlign: TextAlign.center),
                    ],
                  ).paddingAll(16.0);
                }).toList(),
              ),
              Positioned(
                bottom: 30,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DotIndicator(pageController: controller, pages: list),
                    AppButton(
                      onTap: () {
                        finish(context);
                        return MLLoginScreen().launch(context);
                      },
                      child: Text(mlGet_started!, style: boldTextStyle(color: mlPrimaryColor)),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: Text(mlSkip!, style: boldTextStyle(color: blackColor)).paddingOnly(top: 8, right: 8).onTap(() {
                  finish(context);
                  MLLoginScreen().launch(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
