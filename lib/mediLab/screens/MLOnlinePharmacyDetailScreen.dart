import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MLCategoryComponent.dart';
import '../components/MLCategoryProductComponent.dart';
import '../utils/MLColors.dart';
import '../utils/MLCommon.dart';

class MLOnlinePharmacyDetailScreen extends StatefulWidget {
  static String tag = '/MLOnlinePharmacyDetailScreen';
  final int? index;

  const MLOnlinePharmacyDetailScreen({super.key, this.index});

  @override
  MLOnlinePharmacyDetailScreenState createState() =>
      MLOnlinePharmacyDetailScreenState();
}

class MLOnlinePharmacyDetailScreenState
    extends State<MLOnlinePharmacyDetailScreen> {
  List<Widget> data = [ MLCategoryProductComponent()];

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
        body: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mlBackToPreviousWidget(context, white),
                    8.width,
                    Text(' الادويه',
                            style: boldTextStyle(color: whiteColor, size: 20))
                        .expand(),
                    const Icon(Icons.home_outlined, color: white, size: 24),
                    8.width,
                  ],
                ),
                8.height,
              ],
            ).paddingAll(16.0),
            data[widget.index!].validate().flexible(),
          ],
        ),
      ),
    );
  }
}
