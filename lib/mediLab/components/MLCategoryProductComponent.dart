import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'MLPharmacyProductComponent.dart';

class MLCategoryProductComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(topRight: 32)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            MLPharmacyProductComponent(),
          ],
        ),
      ),
    );
  }
}
