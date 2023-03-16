import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/MLServiceData.dart';
import '../screens/MLAddToCartScreen.dart';
import '../utils/MLColors.dart';
import '../utils/MLDataProvider.dart';
import '../utils/MLImage.dart';
import '../utils/MLString.dart';

class MLHomeTopComponent extends StatefulWidget {
  static String tag = '/MLHomeTopComponent';

  @override
  _MLHomeTopComponentState createState() => _MLHomeTopComponentState();
}

class _MLHomeTopComponentState extends State<MLHomeTopComponent> {
  int counter = 2;
  List<MLServicesData> data = mlServiceDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: context.width(),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: mlColorDarkBlue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80.0),
        ),
      ),
      child: Column(
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 22, backgroundColor: mlColorCyan, child: Image.asset(ml_ic_profile_picture!)),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mlProfile_name!, style: boldTextStyle(color: whiteColor)),
                      4.height,
                      Text(mlWelcome!, style: secondaryTextStyle(color: white.withOpacity(0.7))),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.search, color: white, size: 24),
                  10.width,
                  Stack(
                    children: [
                      const Icon(Icons.shopping_bag_outlined, color: white, size: 24),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: boxDecorationWithRoundedCorners(backgroundColor: mlColorRed),
                          constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                          child: Text(
                            counter.toString(),
                            style: boldTextStyle(size: 8, color: white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ).onTap(() {
                    MLAddToCartScreen().launch(context);
                  }),
                ],
              )
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          Container(
            margin: const EdgeInsets.only(right: 16.0, left: 16.0),
            transform: Matrix4.translationValues(0, 16.0, 0),
            alignment: Alignment.center,
            decoration: boxDecorationRoundedWithShadow(12),
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: 8.0,
              children: data.map((e) {
                return Container(
                  constraints: BoxConstraints(minWidth: context.width() * 0.25),
                  padding: const EdgeInsets.only(top: 20, bottom: 20.0),
                  child: Column(
                    children: [
                      Image.asset(e.image!, width: 28, height: 28, fit: BoxFit.fill),
                      8.height,
                      Text(e.title.toString(), style: boldTextStyle(size: 12), textAlign: TextAlign.center),
                    ],
                  ),
                ).onTap(() {
                  e.widget.launch(context);
                });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
