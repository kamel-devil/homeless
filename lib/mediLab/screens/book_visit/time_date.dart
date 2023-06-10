import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controller/visitController.dart';
import '../../utils/MLColors.dart';
import 'hour_picked.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  DateTime? _selectedDate;
  VisitController controller = Get.put(VisitController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'اختار التوقيت',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
            ),
            15.height,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
              child: DatePickerWidget(
                looping: false,
                firstDate: DateTime(2023, 01, 01),
                lastDate: DateTime(2060, 1, 1),
                initialDate: DateTime(2023, 1, 12),
                dateFormat: "dd-MMM-yyyy",
                locale: DatePicker.localeFromString('en'),
                onChange: (DateTime newDate, _) => _selectedDate = newDate,
                pickerTheme: const DateTimePickerTheme(
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                  dividerColor: Colors.redAccent,
                ),
              ),
            ),
            25.height,
            AppButton(
              height: 50,
              width: double.infinity,
              color: mlColorDarkBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Continue", style: boldTextStyle(color: white)),
                  8.width,
                  const Icon(Icons.arrow_forward_ios,
                      color: whiteColor, size: 12),
                ],
              ),
              onTap: () {
                controller.updateDate(_selectedDate.toString());
                const Cupert().launch(context);
              },
            ).paddingOnly(right: 16, left: 16, bottom: 16)
          ],
        ),
      ),
    );
  }
}
