import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/MLBottomNavigationBarWidget.dart';
import '../../controller/controller.dart';
import '../../fragments/MLCalendarFragment.dart';
import '../../fragments/MLHomeFragment.dart';
import '../../fragments/MLProfileFragemnt.dart';
import '../map/map.dart';
import '../nicu_chat/api/apis.dart';
import '../nicu_chat/screens/home_screen.dart';

class MLDashboardScreen extends StatefulWidget {
  static String tag = '/MLDashboardScreen';

  const MLDashboardScreen({super.key});

  @override
  _MLDashboardScreenState createState() => _MLDashboardScreenState();
}

class _MLDashboardScreenState extends State<MLDashboardScreen> {
  int currentWidget = 0;
  bool isMaped = false;
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }
  List<Widget> widgets = [
    const MLHomeFragment(),
    const HomeChat(),
    MLCalendarFragment(),
    MLProfileFragment(),
  ];


  @override
  void dispose() {
    setStatusBarColor(Colors.white);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    MapPageController controller = Get.put(MapPageController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Stack(
          children: [
            widgets[currentWidget],
            !isMaped
                ? Container()
                : Center(
                    child: Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_usmfx6bp.json',
                        width: 300,
                        height: 300),
                  ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: showBottomDrawer(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            setState(() {
              isMaped = true;
            });
            controller.getCurrentLocation().whenComplete(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
              setState(() {
                isMaped = false;
              });
            });
          },
          child: const Icon(Icons.location_on),
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
