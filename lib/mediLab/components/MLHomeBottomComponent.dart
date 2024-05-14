import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/MLDepartmentData.dart';
import '../model/MLTopHospitalData.dart';
import '../screens/house_info/hospital_info.dart';
import '../screens/sponsorship_conditions/care.dart';
import '../screens/sponsorship_conditions/fitness.dart';
import '../screens/sponsorship_conditions/learning.dart';
import '../screens/sponsorship_conditions/sponsorship_conditions.dart';
import '../utils/MLColors.dart';
import '../utils/MLDataProvider.dart';
import '../utils/MLString.dart';



class MLHomeBottomComponent extends StatefulWidget {
  static String tag = '/MLHomeBottomComponent';

  @override
  MLHomeBottomComponentState createState() => MLHomeBottomComponentState();
}

class MLHomeBottomComponentState extends State<MLHomeBottomComponent> {
  List<MLDepartmentData> departmentList = mlDepartmentDataList();

  List<MLTopHospitalData> tophospitalList = mlTopHospitalDataList();

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
    return Column(
      children: [
        8.height,
        Row(
          children: [
            Text(mlDepartment!, style: boldTextStyle(size: 18)).expand(),
            // Text(mlView_all!, style: secondaryTextStyle(color: mlColorBlue)),
            // 4.width,
            // Icon(Icons.keyboard_arrow_right, color: mlColorBlue, size: 16),
          ],
        ).paddingOnly(left: 16, right: 16),
        10.height,
        HorizontalList(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          wrapAlignment: WrapAlignment.spaceEvenly,
          itemCount: departmentList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (index == 3) {
                  Get.to(SponsorshipConditions(),
                      duration: const Duration(seconds: 1),
                      transition: Transition.fadeIn);
                }else if(index == 2){
                  Get.to(Fitness(),
                      duration: const Duration(seconds: 1),
                      transition: Transition.fadeIn);
                }else if(index==0){
                  Get.to(Learning(),
                      duration: const Duration(seconds: 1),
                      transition: Transition.fadeIn);
                }else{
                  Get.to(Care(),
                      duration: const Duration(seconds: 1),
                      transition: Transition.fadeIn);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                padding: const EdgeInsets.all(10),
                decoration: boxDecorationRoundedWithShadow(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset((departmentList[index].image).validate(),
                        height: 80, width: 80, fit: BoxFit.fill)
                        .paddingAll(8.0),
                    Text((departmentList[index].title).validate(),
                        style: boldTextStyle()),
                    8.height,
                  ],
                ),
              ),
            );
          },
        ),
        Row(
          children: [
            Text(mlTop_hospital!, style: boldTextStyle(size: 18)).expand(),
            // Text(mlView_all!, style: secondaryTextStyle(color: mlColorBlue)),
            // 4.width,
            // Icon(Icons.keyboard_arrow_right, color: mlColorBlue, size: 16),
          ],
        ).paddingAll(16.0),
        FutureBuilder(
            future:getData() ,
            builder: (context,snapshot) {
              if(snapshot.hasData){
                List getData =snapshot.data as List;
                return HorizontalList(
                    padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                    wrapAlignment: WrapAlignment.spaceBetween,
                    itemCount: getData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalInfo(uid:getData[index]['uid'], email: getData[index]['email'],),));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8, left: 8),
                          decoration: boxDecorationRoundedWithShadow(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network((getData[index]['profile']),
                                  height: 140, width: 250, fit: BoxFit.fill)
                                  .cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                              8.height,
                              Text((getData[index]['name']),
                                  style: boldTextStyle())
                                  .paddingOnly(left: 8.0),
                              4.height,
                              Text((getData[index]['address']),
                                  style: secondaryTextStyle())
                                  .paddingOnly(left: 8.0),
                              10.height
                            ],
                          ),
                        ),
                      );
                    });

              }else{
                return const Center(child: CircularProgressIndicator());
              }
            }
        ),
      ],
    );
  }
  getData() async {
    QuerySnapshot data =
    await FirebaseFirestore.instance.collection('home').get();
    return data.docs;
  }

}
