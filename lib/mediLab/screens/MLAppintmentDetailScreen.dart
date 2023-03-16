import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MLAppointmentDetailList.dart';
import '../utils/MLColors.dart';
import '../utils/MLCommon.dart';

class MLAppointmentDetailScreen extends StatefulWidget {
  static String tag = '/MLAppointmentDetailScreen';

  @override
  MLAppointmentDetailScreenState createState() => MLAppointmentDetailScreenState();
}

class MLAppointmentDetailScreenState extends State<MLAppointmentDetailScreen> {
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
        body: Container(
          decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(topRight: 32)),
          child: Column(
            children: [
              8.height,
              Row(
                children: [
                  mlBackToPreviousWidget(context, black),
                  Text('Appointment Details', style: boldTextStyle(size: 24)),
                ],
              ).paddingAll(16),
              Flexible(child: MLAppointmentDetailList()),
            ],
          ),
        ),
      ),
    );
  }
}
