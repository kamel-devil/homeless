import 'dart:math';

import 'package:flutter/material.dart';

import 'package:homeless/mediLab/components/defaulttextformfield.dart';

import 'package:timelines/timelines.dart';

class OrderRequest extends StatefulWidget {
  const OrderRequest({Key? key}) : super(key: key);

  @override
  State<OrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  PageController controller = PageController();

  TextEditingController fName = TextEditingController();

  TextEditingController lName = TextEditingController();

  TextEditingController tName = TextEditingController();

  TextEditingController nickName = TextEditingController();

  TextEditingController statue = TextEditingController();

  TextEditingController deyana = TextEditingController();

  TextEditingController edu = TextEditingController();

  TextEditingController jop = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController idNumber = TextEditingController();

  TextEditingController country = TextEditingController();

  TextEditingController travelNumber = TextEditingController();

  TextEditingController birthDay = TextEditingController();

  TextEditingController nationality = TextEditingController();

  TextEditingController rigon = TextEditingController();

  TextEditingController center = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  bool maleSelected = false;
   double kTileHeight = 50.0;

   Color completeColor = Color(0xff5e6172);
   MaterialAccentColor inProgressColor = Colors.redAccent;
   Color todoColor = Color(0xffd1d2d7);
  bool femaleSelected = false;
  int _processIndex = 0;
  final _processes = [
    'بيانات الام',
    'جنسيه الام',
    'بيانات السكن',
    'بيانات الطفل',
  ];

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text(
          'طلب كفاله',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: const ConnectorThemeData(
                  space: 30.0,
                  thickness: 5.0,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemExtentBuilder: (_, __) =>
                    MediaQuery.of(context).size.width / _processes.length,
                oppositeContentsBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Image.asset(
                      'images/mediLab/images/ml_doctor.png',
                      width: 50.0,
                      color: getColor(index),
                    ),
                  );
                },
                contentsBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      _processes[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getColor(index),
                      ),
                    ),
                  );
                },
                indicatorBuilder: (_, index) {
                  var color;
                  var child;
                  if (index == _processIndex) {
                    color = inProgressColor;
                    child = const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  } else if (index < _processIndex) {
                    color = completeColor;
                    child = const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15.0,
                    );
                  } else {
                    color = todoColor;
                  }

                  if (index <= _processIndex) {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: const Size(30.0, 30.0),
                          painter: _BezierPainter(
                            color: color,
                            drawStart: index > 0,
                            drawEnd: index < _processIndex,
                          ),
                        ),
                        DotIndicator(
                          size: 30.0,
                          color: color,
                          child: child,
                        ),
                      ],
                    );
                  } else {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: const Size(15.0, 15.0),
                          painter: _BezierPainter(
                            color: color,
                            drawEnd: index < _processes.length - 1,
                          ),
                        ),
                        OutlinedDotIndicator(
                          borderWidth: 4.0,
                          color: color,
                        ),
                      ],
                    );
                  }
                },
                connectorBuilder: (_, index, type) {
                  if (index > 0) {
                    if (index == _processIndex) {
                      final prevColor = getColor(index - 1);
                      final color = getColor(index);
                      List<Color> gradientColors;
                      if (type == ConnectorType.start) {
                        gradientColors = [
                          Color.lerp(prevColor, color, 0.5)!,
                          color
                        ];
                      } else {
                        gradientColors = [
                          prevColor,
                          Color.lerp(prevColor, color, 0.5)!
                        ];
                      }
                      return DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                        ),
                      );
                    } else {
                      return SolidLineConnector(
                        color: getColor(index),
                      );
                    }
                  } else {
                    return null;
                  }
                },
                itemCount: _processes.length,
              ),
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _processIndex = index;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 20, bottom: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Card(
                          elevation: 3,
                          color: Colors.redAccent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 38),
                            child: Text(
                              'بيانات الام البديله',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'الاسم الاول :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: "الاسم الاول",
                            pIcon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: fName),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'الاسم التاني :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: "الاسم الثاني",
                            pIcon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: lName),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'الاسم الثالث :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: "الاسم الثالث",
                            pIcon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: tName),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'اللقب',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: "اللقب",
                            pIcon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: nickName),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "الحاله الاجتماعيه",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: "الحاله الاجتماعيه",
                            pIcon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: statue),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "الديانه",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: "الديانه",
                            pIcon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: deyana),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'المرحله التعليميه',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'المرحله التعليميه',
                            pIcon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: edu),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'المهنه',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'المهنه',
                            pIcon: const Icon(
                              Icons.work,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: jop),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "المحمول",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: "المحمول",
                            pIcon: const Icon(
                              Icons.phone,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: phone),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "البريد الالكتروني",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: "البريد الالكتروني",
                            pIcon: const Icon(
                              Icons.email,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: email),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.nextPage(
                                duration: const Duration(seconds: 3),
                                curve: Curves.fastLinearToSlowEaseIn);
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black12.withOpacity(.2),
                                      offset: const Offset(2, 2))
                                ],
                                borderRadius: BorderRadius.circular(20)
                                    .copyWith(
                                        bottomRight: const Radius.circular(0)),
                                gradient: LinearGradient(colors: [
                                  Colors.redAccent.shade200,
                                  Colors.red.shade900
                                ])),
                            child: Text('التالي',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 20, bottom: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Card(
                          elevation: 3,
                          color: Colors.redAccent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 38),
                            child: Text(
                              'بيانات الجنسيه الام البديله',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'الرقم القومي :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'الرقم القومي :-',
                            pIcon: const Icon(
                              Icons.numbers,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: idNumber),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'محافظه الميلاد :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'محافظه الميلاد :-',
                            pIcon: const Icon(
                              Icons.language,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: country),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'تاريخ الميلاد :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'تاريخ الميلاد :-',
                            pIcon: const Icon(
                              Icons.calendar_view_day,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: birthDay),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'رقم جواز السفر',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'رقم جواز السفر',
                            pIcon: const Icon(
                              Icons.confirmation_num,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: travelNumber),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'الجنسيه',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'الجنسيه',
                            pIcon: const Icon(
                              Icons.confirmation_num,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: nationality),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.decelerate);
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black12.withOpacity(.2),
                                      offset: const Offset(2, 2))
                                ],
                                borderRadius: BorderRadius.circular(20)
                                    .copyWith(
                                        bottomRight: const Radius.circular(0)),
                                gradient: LinearGradient(colors: [
                                  Colors.redAccent.shade200,
                                  Colors.red.shade900
                                ])),
                            child: Text('التالي',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 20, bottom: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Card(
                          elevation: 3,
                          color: Colors.redAccent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 38),
                            child: Text(
                              'بيانات السكن داخل مصر',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'المحافظه :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'المحافظه :-',
                            pIcon: const Icon(
                              Icons.location_city_outlined,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: rigon),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'فسم / مركز :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'فسم / مركز :-',
                            pIcon: const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: center),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'العنوان:-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'العنوان:-',
                            pIcon: const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: address),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'التليفون',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'التليفون',
                            pIcon: const Icon(
                              Icons.phone,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: phoneNumber),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.decelerate);
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black12.withOpacity(.2),
                                      offset: const Offset(2, 2))
                                ],
                                borderRadius: BorderRadius.circular(20)
                                    .copyWith(
                                        bottomRight: const Radius.circular(0)),
                                gradient: LinearGradient(colors: [
                                  Colors.redAccent.shade200,
                                  Colors.red.shade900
                                ])),
                            child: Text('التالي',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 20, bottom: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Card(
                          elevation: 3,
                          color: Colors.redAccent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 38),
                            child: Text(
                              'بيانات الطفل',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'نوع الطفل :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  maleSelected = true;

                                  femaleSelected = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.redAccent)),
                                      child: maleSelected
                                          ? Container(
                                              margin: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.redAccent),
                                            )
                                          : const SizedBox()),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text('Male',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  femaleSelected = true;

                                  maleSelected = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.redAccent,
                                              width: 2)),
                                      child: femaleSelected
                                          ? Container(
                                              margin: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.redAccent),
                                            )
                                          : const SizedBox()),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text('Female',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'العمر من :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'العمر من :-',
                            pIcon: const Icon(
                              Icons.numbers_outlined,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: center),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'العمر الي :-',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultTextFormField(
                            hint: 'العمر الي :-',
                            pIcon: const Icon(
                              Icons.numbers,
                              color: Colors.redAccent,
                            ),
                            val: false,
                            controller: address),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.animateToPage(0,
                                duration: const Duration(seconds: 3),
                                curve: Curves.ease);
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black12.withOpacity(.2),
                                      offset: const Offset(2, 2))
                                ],
                                borderRadius: BorderRadius.circular(20)
                                    .copyWith(
                                        bottomRight: const Radius.circular(0)),
                                gradient: LinearGradient(colors: [
                                  Colors.redAccent.shade200,
                                  Colors.red.shade900
                                ])),
                            child: Text('مراجعه البيانات',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black12.withOpacity(.2),
                                      offset: const Offset(2, 2))
                                ],
                                borderRadius: BorderRadius.circular(20)
                                    .copyWith(
                                        bottomRight: const Radius.circular(0)),
                                gradient: LinearGradient(colors: [
                                  Colors.redAccent.shade200,
                                  Colors.red.shade900
                                ])),
                            child: Text('ارسال',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
