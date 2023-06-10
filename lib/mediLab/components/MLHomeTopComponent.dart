import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/MLServiceData.dart';
import '../screens/MLAddToCartScreen.dart';
import '../screens/order/applyfromsite.dart';
import '../screens/order/order.dart';
import '../utils/MLColors.dart';
import '../utils/MLDataProvider.dart';
import '../utils/MLImage.dart';
import '../utils/MLString.dart';

class MLHomeTopComponent extends StatefulWidget {
  static String tag = '/MLHomeTopComponent';

  const MLHomeTopComponent({super.key});

  @override
  _MLHomeTopComponentState createState() => _MLHomeTopComponentState();
}

class _MLHomeTopComponentState extends State<MLHomeTopComponent> {
  int counter = 2;
  List<MLServicesData> data = mlServiceDataList();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  CircleAvatar(
                      radius: 22,
                      backgroundColor: mlColorCyan,
                      child: Image.asset(ml_ic_profile_picture)),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi',
                          style: boldTextStyle(color: whiteColor)),
                      4.height,
                      Text(mlWelcome!,
                          style: secondaryTextStyle(
                              color: white.withOpacity(0.7))),
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
                      const Icon(Icons.shopping_bag_outlined,
                          color: white, size: 24),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: mlColorRed),
                          constraints:
                              const BoxConstraints(minWidth: 12, minHeight: 12),
                          child: Text(
                            counter.toString(),
                            style: boldTextStyle(size: 8, color: white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ).onTap(() {
                    const MLAddToCartScreen().launch(context);
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        e.image!,
                        width: 40,
                        height: 35,
                        fit: BoxFit.fill,
                        // color: Colors.redAccent,
                      ),
                      8.height,
                      Text(
                        e.title.toString(),
                        style: boldTextStyle(
                          size: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ).onTap(() {
                  if (e.title == 'اكفل طفل') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrderRequest()));
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          color: Colors.black12.withOpacity(.2),
                                          offset: const Offset(2, 2))
                                    ],
                                    borderRadius: BorderRadius.circular(20)
                                        .copyWith(
                                            bottomRight:
                                                const Radius.circular(0)),
                                    gradient: LinearGradient(colors: [
                                      Colors.redAccent.shade200,
                                      Colors.red.shade900
                                    ])),
                                child: Text('قدم الان',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ApplyFromSite()));
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          color: Colors.black12.withOpacity(.2),
                                          offset: const Offset(2, 2))
                                    ],
                                    borderRadius: BorderRadius.circular(20)
                                        .copyWith(
                                            bottomRight:
                                                const Radius.circular(0)),
                                    gradient: LinearGradient(colors: [
                                      Colors.redAccent.shade200,
                                      Colors.red.shade900
                                    ])),
                                child: Text('عبر موقع الوزاره',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900)),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    e.widget.launch(context);
                  }
                });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
