import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MLBottomNavigationBarWidget.dart';
import '../fragments/MLCalendarFragment.dart';
import '../fragments/MLChatFragment.dart';
import '../fragments/MLHomeFragment.dart';
import '../fragments/MLNotificationFragment.dart';
import '../fragments/MLProfileFragemnt.dart';
class MLDashboardScreen extends StatefulWidget {
  static String tag = '/MLDashboardScreen';

  @override
  _MLDashboardScreenState createState() => _MLDashboardScreenState();
}

class _MLDashboardScreenState extends State<MLDashboardScreen> {
  int currentWidget = 0;
  List<Widget> widgets = [
    MLHomeFragment(),
    MLChatFragment(),
    MLCalendarFragment(),
    MLNotificationFragment(),
    MLProfileFragment(),
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
  void dispose() {
    setStatusBarColor(Colors.white);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: widgets[currentWidget],
        bottomNavigationBar: Container(
          color: Colors.white,
          child: showBottomDrawer(),
        ),
      ),
    );
  }

  Widget showBottomDrawer() {
    return MLBottomNavigationBarWidget(
      index: currentWidget,
      onTap: (index) {
        setState(() {});
        currentWidget = index;
      },
    );
  }
}
