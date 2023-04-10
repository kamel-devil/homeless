import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MLPharmacyCategoriesComponent.dart';
import '../utils/MLColors.dart';
import '../utils/MLCommon.dart';
import '../utils/MLImage.dart';

class MLOnlinePharmacyScreen extends StatefulWidget {
  static String tag = '/MLOnlinePharmacyScreen';

  const MLOnlinePharmacyScreen({super.key});

  @override
  MLOnlinePharmacyScreenState createState() => MLOnlinePharmacyScreenState();
}

class MLOnlinePharmacyScreenState extends State<MLOnlinePharmacyScreen> {
  PageController controller = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );
  List<String> slides = <String>[
    ml_ic_pharmacySlide3,
    ml_ic_pharmacySlide1,
    ml_ic_pharmacySlide2,
    ml_ic_pharmacySlide4,
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: context.height() * 0.55,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlPrimaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          mlBackToPreviousWidget(context, white),
                          8.width,
                        ],
                      ).paddingAll(16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('', style: boldTextStyle(size: 32, color: white)),
                              Text('الادويه', style: boldTextStyle(size: 32, color: white)),
                            ],
                          ).expand(),
                          const Icon(Icons.search, color: white, size: 24),
                          8.width,
                          const Icon(Icons.shopping_bag_outlined, color: white, size: 24),
                        ],
                      ).paddingAll(16.0),
                      8.height,
                      SizedBox(
                        height: 180,
                        width: context.width(),
                        child: PageView(
                          controller: controller,
                          children: slides.map((e) {
                            return Image.asset(e.validate(), fit: BoxFit.fill).cornerRadiusWithClipRRect(12.0).paddingRight(16.0);
                          }).toList(),
                        ),
                      ),
                      16.height,
                      DotIndicator(pageController: controller, pages: slides, unselectedIndicatorColor: white.withOpacity(0.5)),
                      16.height,
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return const MLPharmacyCategoriesComponent();
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
