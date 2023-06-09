import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MLCasesComponent.dart';
import '../components/MLCountryPIckerComponent.dart';
import '../components/MLNewsAndVideoComponent.dart';
import '../components/MLVacciensComponent.dart';
import '../utils/MLColors.dart';
import '../utils/MLCommon.dart';
import '../utils/MLImage.dart';
import '../utils/MLString.dart';


class MLCovidScreen extends StatefulWidget {
  static String tag = '/MLCovidScreen';

  @override
  MLCovidScreenState createState() => MLCovidScreenState();
}

class MLCovidScreenState extends State<MLCovidScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                mlBackToPreviousIcon(context, white),
                8.width,
                Text('Covid-19', style: boldTextStyle(color: whiteColor, size: 20)).expand(),
                Row(
                  children: [
                    Image.asset(ml_ic_icon_help!, width: 16, height: 16),
                    Text('Help', style: secondaryTextStyle(color: white, size: 16)),
                  ],
                ),
              ],
            ).paddingAll(16.0),
            Container(
              width: context.width(),
              decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(topRight: 32)),
              child: Column(
                children: [
                  16.height,
                  Row(
                    children: [
                      MLCountryPickerComponent(),
                      4.width,
                      Text(mlGlobal_status!, style: boldTextStyle()).expand(),
                      Text('152.799.358', style: boldTextStyle()),
                      16.width,
                    ],
                  ).paddingOnly(right: 16, left: 16),
                  const Divider(thickness: 1.0).paddingOnly(right: 16, left: 16),
                  TabBar(
                    controller: _tabController,
                    labelColor: mlColorBlue,
                    indicatorColor: mlColorBlue,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: primaryTextStyle(size: 14),
                    tabs: [
                      const Tab(text: 'Cases'),
                      const Tab(text: 'Vaccines'),
                      const Tab(text: 'News & Videos'),
                    ],
                  ),
                  Flexible(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        MLCasesComponent(),
                        MLVaccineComponent(),
                        MLNewsAnVideoComponent(),
                      ],
                    ),
                  ),
                ],
              ),
            ).flexible()
          ],
        ),
      ),
    );
  }
}
