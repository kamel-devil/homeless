import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/MLMedicationData.dart';
import '../screens/MLProductDetailScreen.dart';
import '../utils/MLColors.dart';
import '../utils/MLDataProvider.dart';
class MLPharmacyProductComponent extends StatefulWidget {
  static String tag = '/MLPharmacyProductComponent';

  @override
  MLPharmacyProductComponentState createState() => MLPharmacyProductComponentState();
}

class MLPharmacyProductComponentState extends State<MLPharmacyProductComponent> {
  List<MLMedicationData> listTwo = mlPrescriptionMedicineDataList();

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
        Row(
          children: [
            Text('الادوية', style: boldTextStyle(size: 20)).expand(),
            const Icon(Icons.format_line_spacing, color: black, size: 24),
          ],
        ),
        16.height,
        FutureBuilder(
          future: getClients(),
          builder: (context,snapshot) {
            if(snapshot.hasData){
              List  data =snapshot.data as List;
              return StaggeredGridView.countBuilder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(

                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: radius(12),
                      border: Border.all(color: mlColorLightGrey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image.network((data[index]['image']), height: 120, width: context.width(), fit: BoxFit.cover).cornerRadiusWithClipRRectOnly(topRight: 8, topLeft: 8),
                          ],
                        ),
                        16.height,
                        Row(
                          children: [
                            Image.asset('images/mediLab/images/required.png',width: 35,height: 35,),

                            4.width,
                            Text(('${data[index]['important']}/10'), style: secondaryTextStyle()),
                          ],
                        ).paddingOnly(left: 10, right: 10),
                        8.height,
                        Text((data[index]['name']), style: boldTextStyle()).paddingOnly(left: 10, right: 10),
                        4.height,
                        Text(('\$ ${data[index]['price']}'), style: boldTextStyle()).paddingOnly(left: 10, right: 10),
                        12.height,
                      ],
                    ),
                  ).onTap(() {
                    MLProductDetailScreen(data[index]).launch(context);
                  });
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              );

            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      ],
    ).paddingAll(16.0);
  }
  Future getClients() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Drugs").get();
    return qn.docs;
  }
}
