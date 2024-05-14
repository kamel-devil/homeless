import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/MLProductMoreDetailScreen.dart';

class MLProductDetailComponent extends StatefulWidget {
  static String tag = '/MLProductDetailComponent';
final data;

  const MLProductDetailComponent(this.data, {super.key});
  @override
  MLProductDetailComponentState createState() => MLProductDetailComponentState();
}

class MLProductDetailComponentState extends State<MLProductDetailComponent> {
  String? pillName = 'Tmrw Pill Bottle Vitamin';
  String? numberOfPill = 'Tablets : 50/100/150 Pills';
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(topLeft: 24, topRight: 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.data['name'], style: boldTextStyle(size: 20)),

            ],
          ),
          8.height,
          Text(widget.data['info'], style: boldTextStyle(color: Colors.grey)),
          16.height,
          const Divider(thickness: 1.0),
          // 8.height,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('Overview', style: boldTextStyle()),
          //     Icon(Icons.arrow_forward_ios_outlined, size: 20, color: Colors.blue.shade600),
          //   ],
          // ).onTap(() {
          //   MLProductMoreDetailScreen().launch(context);
          // }),
          // 8.height,
          // const Divider(thickness: 1.0),
          8.height,
          Text('Specification', style: boldTextStyle()),
          16.height,
          Table(
            children: [
              TableRow(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.local_hospital_outlined, color: Colors.blue, size: 18),
                        4.width,
                        Text('Specialist', style: boldTextStyle()),
                      ],
                    ),
                    4.height,
                    Text(widget.data['specialist'], style: secondaryTextStyle(size: 16)),
                  ],
                ).paddingRight(16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.people_alt_outlined, color: Colors.blue, size: 18),
                        4.width,
                        Text('Age Range', style: boldTextStyle()),
                      ],
                    ),
                    4.height,
                    Text(widget.data['age'], style: secondaryTextStyle(size: 16)),
                  ],
                ),
              ])
            ],
          ),
          64.height,
        ],
      ),
    );
  }
}
