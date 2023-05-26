import 'package:get/get.dart';

class VisitController extends GetxController {
  var visitData;
  String time = '';
  String date = '';

  void updateVisitData( data) {
    visitData = data;
    update();
  }

  void updateTime(String time1) {
    time = time1;
    update();
  }

  void updateDate(String date1) {
    date = date1;
    update();
  }
}
