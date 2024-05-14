import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../components/MLProfileBottomComponent.dart';
import '../screens/nicu_chat/api/apis.dart';
import '../screens/nicu_chat/screens/profile_screen.dart';
import '../utils/MLColors.dart';
import '../utils/MLImage.dart';

class MLProfileFragment extends StatefulWidget {
  static String tag = '/MLProfileFragment';

  @override
  MLProfileFragmentState createState() => MLProfileFragmentState();
}

class MLProfileFragmentState extends State<MLProfileFragment> {
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

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 225,
              flexibleSpace: FlexibleSpaceBar(
                background: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                  user: APIs.me,
                                )));
                  },
                  child: Container(
                    color: mlColorDarkBlue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage: NetworkImage(APIs.me.image),
                                radius: 40.0,
                                backgroundColor: mlColorCyan),
                            8.height,
                            Text(APIs.me.name,
                                style: boldTextStyle(color: white, size: 24)),
                            4.height,
                            Text(APIs.me.email,
                                style:
                                    secondaryTextStyle(color: white, size: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return MLProfileBottomComponent();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
