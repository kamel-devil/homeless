import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/MLAppointmentData.dart';
import '../screens/MLAppintmentDetailScreen.dart';
import '../utils/MLColors.dart';
import '../utils/MLDataProvider.dart';
import '../utils/MLString.dart';


class MLAppointmentDetailListComponent extends StatefulWidget {
  static String tag = '/MLAppointmentDetailListComponent';

  @override
  MLAppointmentDetailListComponentState createState() => MLAppointmentDetailListComponentState();
}

class MLAppointmentDetailListComponentState extends State<MLAppointmentDetailListComponent> {
  String? time = 'Today, 9:30 PM';

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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      child: FutureBuilder(
        future:getClients() ,
        builder: (context,snapshot) {
          if(snapshot.hasData){
            List data =snapshot.data as List;
            return Column(
              children: data.map((e) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.grey.shade50,
                        borderRadius: radius(12),
                      ),
                      child: Column(
                        children: [
                          20.height,
                          Row(
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: boxDecorationWithRoundedCorners(backgroundColor: mlColorDarkBlue, borderRadius: radius(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text((e['date']), style: boldTextStyle(size: 32, color: white)),
                                  ],
                                ),
                              ),
                              8.width,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text((e['home']), style: boldTextStyle(size: 18)),
                                      8.height,
                                      Text((e['address']), style: secondaryTextStyle()),
                                    ],
                                  ),
                                ],
                              ).expand(),
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          8.height,
                          const Divider(thickness: 0.5),
                          8.height,
                          Row(
                            children: [
                              Text(e['time'], style: boldTextStyle(color: mlColorDarkBlue)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(mlAppointment_detail!, style: secondaryTextStyle(color: mlColorDarkBlue)),
                                  4.width,
                                  Icon(Icons.arrow_forward, color: mlPrimaryColor, size: 16),
                                ],
                              ).onTap(() {
                                MLAppointmentDetailScreen().launch(context);
                              }).expand()
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          16.height,
                        ],
                      ),
                    ).paddingBottom(16.0),
                  ],
                );
              }).toList(),
            );

          }else{
            return const Center(child: CircularProgressIndicator());
          }

        }
      ),
    );
  }
  Future getClients() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("visit").where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    return qn.docs;
  }
}
