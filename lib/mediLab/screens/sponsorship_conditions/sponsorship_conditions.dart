import 'package:flutter/material.dart';

class SponsorshipConditions extends StatelessWidget {
  SponsorshipConditions({Key? key}) : super(key: key);
  List<String> text = [
    'يجب أن يكون أحد الزوجين مصري، وأن تتماثل ديانة الأسرة مع ديانة الطفل',
    'أن تتمتع الأسرة المحتضنة بالمستوى الأخلاقي والاجتماعي المطلوب.',
    'يمر على الزواج 3 سنوات على الأقل أو إثبات حالة العقم الدائم لأي من الزوجين.',
    'يجب أن يكون عمر الزوجين لا يقل عن 21 عام ولا يزيد عن 60 عام.',
    'يشترط توافر الصلاحية الاجتماعية والنفسية والصحية للرعاية والاهتمام باحتياجات الطفل المحتضن.',
    'تقديم صحيفة حالة جنائية للأسرة المحتضنة.',
    'يشترط ألا يزيد عدد الأطفال لدى الأسرة المحتضنة عن طفلين أو أن يكونوا وصلوا لمرحلة يمكنهم فيها الاعتماد على النفس.',
    'أن تتوافر البيئة الصالحة لتربية الطفل من توافر مؤسسات طبية ورياضية وتعليمية ودينية.',
    'يجب أن تتمتع الأسرة بالقدرة المادية الكافية لتربية الطفل بشكل مناسب.',
    'الحفاظ على نسب الطفل مع أخذ تعهد كتابي من الأسرة المحتضنة بذلك.',
    'يشترط أن يكون الزوجان حاصلين على شهادات تعليم متوسط على الأقل، كما يمكن استثناء هذا الشرط وفقًا لرؤية لجنة البحث الاجتماعي.',
    'تقدم الأسرة الكافلة رعايتها للطفل المعني بدون مقابل مع إمكانية تخصيص هبة له من الأملاك حسب القانون.',
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
              child: Column(
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
                        'شروط الاحتضان في مصر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  const Text(
                    '    الشروط والأحكام :-',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    'يعتمد هذا النظام الذي بدأته الوزارة عام 1959 م على إلحاق الأطفال المحرومين من الرعاية الأسرية خاصة مجهولى النسب بأسر يتم إختيارها وفقاً لشروط ومعايير تؤكد صلاحية الأسرة وسلامة مقاصدها لرعاية هؤلاء الأطفال دون إستغلال لهم أو لمصالح ذاتية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}.  ',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        Flexible(
                          child: Text(
                            text[index],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    itemCount: text.length,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
