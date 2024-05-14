import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeless/mediLab/controller/visitController.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/MLDepartmentData.dart';
import '../utils/MLColors.dart';
import '../utils/MLCommon.dart';
import '../utils/MLDataProvider.dart';

class MLClinicVisitComponent extends StatefulWidget {
  const MLClinicVisitComponent({super.key});

  @override
  MLClinicVisitComponentState createState() => MLClinicVisitComponentState();
}

class MLClinicVisitComponentState extends State<MLClinicVisitComponent> {
  static String tag = '/MLClinicVisitComponent';
  List<MLDepartmentData> departmentList = mlServiceListDataList();
  int? selectedIndex = 0;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  getData() async {
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('home').get();
    return data.docs;
  }

  VisitController controller = Get.put(VisitController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          16.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('اختار دار الرعايه', style: boldTextStyle(size: 24)),
                  8.height,
                  Text('اهلا بك ..', style: secondaryTextStyle()),
                  16.height,
                ],
              ).expand(),
              mlRoundedIconContainer(Icons.search, mlColorBlue),
              16.width,
              mlRoundedIconContainer(
                  Icons.calendar_view_day_outlined, mlColorBlue),
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          8.height,
          FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List data = snapshot.data as List;
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                        right: 16.0, left: 16.0, bottom: 70),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(8.0),
                        decoration: boxDecorationWithRoundedCorners(
                          border: Border.all(
                              color: selectedIndex == index
                                  ? mlColorBlue
                                  : mlColorLightGrey100),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network((data[index]['profile']),
                                        height: 75, width: 75, fit: BoxFit.fill)
                                    .paddingAll(8.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((data[index]['name']),
                                        style: boldTextStyle(size: 18)),
                                    8.height,
                                    Text(data[index]['open'],
                                        style: secondaryTextStyle()),
                                    8.height,
                                    Text((data[index]['phone']),
                                        style: boldTextStyle(
                                            color: mlColorDarkBlue)),
                                  ],
                                ),
                              ],
                            ),
                            8.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                          child: Icon(
                                              Icons.watch_later_outlined,
                                              size: 14)),
                                      TextSpan(
                                          text: ' next available time',
                                          style: secondaryTextStyle()),
                                    ],
                                  ),
                                ),
                                Text('',
                                    style: secondaryTextStyle(
                                        color: Colors.black87)),
                              ],
                            ).paddingOnly(left: 8, right: 8),
                            8.height,
                          ],
                        ),
                      ).onTap(
                        () {
                          setState(() {
                            selectedIndex = index;
                            controller.updateVisitData(data[index]);
                          });
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
