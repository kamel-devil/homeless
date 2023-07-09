import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../MLAddPaymentScreen.dart';

class Care extends StatelessWidget {
  Care({Key? key}) : super(key: key);
  List text = [
    {'image':'https://static.dw.com/image/56160022_6.jpg',
      'title':'تطعيمات الاطفال',
      'subTitle':'لقد طعمنا اكثر من 100 طفل ',
    },
    {'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIYWMeeYz_Npj8fKXTa7kmHtB62oiDWZtXxQ&usqp=CAU',
      'title':'رعايه',
      'subTitle':'نقوم برعايه المسنين',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.redAccent.shade100,
                ],
              )),
          child: Padding(
            padding:
            const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 10),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/mediLab/images/ml_voucher_two.png',
                            width: 60,
                            height: 50,
                          ),
                          const Text(
                            'الرعاية ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Card(
                          color: appStore.appBarColor,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                  child: Image.network(text[index]['image'], height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
                                ),
                                10.height,
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16),
                                  child: Text(
                                    text[index]['title'],
                                    style: boldTextStyle(size: 20, color: appStore.textPrimaryColor),
                                  ),
                                ),
                                10.height,
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16),
                                  child: Text(
                                    text[index]['subTitle'],

                                    style: secondaryTextStyle(size: 16, color: appStore.textSecondaryColor),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        itemCount: text.length,
                      ),
                      10.height,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MLAddPaymentScreen()));
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          margin:
                          const EdgeInsets.symmetric(horizontal: 40),
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
                                  bottomRight:
                                  const Radius.circular(0)),
                              gradient: LinearGradient(colors: [
                                Colors.redAccent.shade200,
                                Colors.red.shade900
                              ])),
                          child: Text('ادعم الان',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
