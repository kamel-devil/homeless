import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MLHospitalDetailComponent.dart';
import '../utils/MLColors.dart';
import '../utils/MLCommon.dart';
import '../utils/MLImage.dart';

class MLHospitalDetailScreen extends StatefulWidget {
  static String tag = '/MLHospitalDetailScreen';

  @override
  MLHospitalDetailScreenState createState() => MLHospitalDetailScreenState();
}

class MLHospitalDetailScreenState extends State<MLHospitalDetailScreen> {
  double containerHeight = 0;
  bool? liked = false;

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
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 450,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlPrimaryColor,
                  child: Stack(
                    children: [
                      Image.asset(ml_ic_hospital_img!, fit: BoxFit.cover, width: context.width()).cornerRadiusWithClipRRectOnly(topRight: 24),
                      Positioned(
                        top: 16.0,
                        right: 16.0,
                        child: mlIconWithRoundedContainer(Icons.close, black).onTap(() {
                          finish(context);
                        }),
                      ),
                      Positioned(
                        bottom: 16.0,
                        right: 16.0,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: boxDecorationWithRoundedCorners(backgroundColor: white, border: Border.all(color: Colors.grey.shade100), borderRadius: radius(24.0)),
                          child: liked == true
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      liked = false;
                                    });
                                  },
                                  child: const Icon(Icons.favorite, color: Colors.red, size: 16),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      liked = true;
                                    });
                                  },
                                  child: const Icon(Icons.favorite_outline, color: Colors.grey, size: 16),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: radiusOnly(topRight: 12, topLeft: 12),
                      ),
                      child: MLHospitalDetailComponent(),
                    );
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
