import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MLPIllHowToUseComponent.dart';
import '../components/MLPillDetailComponent.dart';
import '../components/MLPillReviewComponent.dart';
import '../utils/MLColors.dart';

class MLProductMoreDetailScreen extends StatefulWidget {
  static String tag = '/MLProductMoreDetailScreen';

  @override
  MLProductMoreDetailScreenState createState() => MLProductMoreDetailScreenState();
}

class MLProductMoreDetailScreenState extends State<MLProductMoreDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: SafeArea(
        child: Container(
          decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(topRight: 32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              24.height,
              Icon(Icons.close, color: mlColorBlue).paddingRight(32.0).onTap(() {
                finish(context);
              }),
              24.height,
              Container(
                decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(topRight: 32)),
                height: context.height(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: mlColorBlue,
                      indicatorColor: mlColorBlue,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: primaryTextStyle(),
                      tabs: const [
                        Tab(text: 'Detail'),
                        Tab(text: 'How to Use'),
                        Tab(text: 'Review'),
                      ],
                    ),
                    TabBarView(
                      controller: _tabController,
                      children: [
                        MLPillDetailComponent(),
                        MLPillHowToUseComponent(),
                        MLPillReviewComponent(),
                      ],
                    ).expand(),
                  ],
                ),
              ).expand(),
            ],
          ),
        ),
      ),
    );
  }
}
