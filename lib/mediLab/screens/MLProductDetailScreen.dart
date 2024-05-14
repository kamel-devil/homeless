import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/MLProductDetailComponent.dart';
import '../utils/MLColors.dart';
import '../utils/MLCommon.dart';
import '../utils/MLImage.dart';
import 'MLAddPaymentScreen.dart';

class MLProductDetailScreen extends StatefulWidget {
  static String tag = '/MLProductDetailScreen';

  MLProductDetailScreen(this.data);

  final data;

  @override
  MLProductDetailScreenState createState() => MLProductDetailScreenState();
}

class MLProductDetailScreenState extends State<MLProductDetailScreen> {


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: white,
                  automaticallyImplyLeading: false,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                          width: double.infinity,
                          height: context.height() * 0.42,
                          color: Colors.grey.shade50,
                          child: Image.network(widget.data['image'],
                              fit: BoxFit.fill),
                        ),
                        mlBackToPreviousWidget(context, black)
                            .paddingOnly(left: 16, top: 16)
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0) {
                        return MLProductDetailComponent(widget.data);
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            AppButton(
              color: mlPrimaryColor,
              width: context.width(),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MLAddPaymentScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ادعم الان', style: boldTextStyle(color: white)),
                  4.width,
                  const Icon(Icons.support, color: white),
                ],
              ),
            ).paddingOnly(right: 16.0, left: 16.0, bottom: 8.0),
          ],
        ),
      ),
    );
  }
}
