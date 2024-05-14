import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/ExpirationTextField.dart';
import '../../components/FlipCard.dart';
import '../home/MLDashboardScreen.dart';





class DTPaymentScreen extends StatefulWidget {
  static String tag = '/DTPaymentScreen';

  @override
  DTPaymentScreenState createState() => DTPaymentScreenState();
}

class DTPaymentScreenState extends State<DTPaymentScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  var cardNumberCont = TextEditingController();
  var cardHolderCont = TextEditingController();
  var expiryDateCont = TextEditingController(text: 'MM/YY');
  var securityCodeCont = TextEditingController();

  var cardHolderFocus = FocusNode();
  var expiryDateFocus = FocusNode();
  var securityCodeFocus = FocusNode();

  var isFocusOnSecurityCode = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    securityCodeFocus.addListener(() {
      cardKey.currentState!.toggleCard();

      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    securityCodeFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (_) => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfffab585),
            elevation: 0,
            title: const Text(
              'Payment',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back,color: Colors.black),),
            centerTitle: true,
          ),
          body: Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: FlipCard(
                        key: cardKey,
                        front: Container(
                          decoration: BoxDecoration(color: const Color(0xfffab585).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Image.asset('assets/ic_mastercard.png'),
                                height: 40,
                                right: 8,
                                top: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      cardNumberCont.text.padRight(16, '*').replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} "),
                                      style: boldTextStyle(size: 24),
                                    ),
                                  ),
                                  30.height,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('card Holder', style: primaryTextStyle(size: 16)),
                                      Text('Expiry', style: primaryTextStyle(size: 16)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cardHolderCont.text,
                                        style: boldTextStyle(size: 24),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ).expand(),
                                      Text(expiryDateCont.text, style: boldTextStyle(size: 24)),
                                    ],
                                  ),
                                ],
                              ).paddingOnly(left: 16, right: 16),
                            ],
                          ),
                        ),
                        back: Container(
                          decoration: BoxDecoration(color: const Color(0xfffab585).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(height: 40, color: Colors.black),
                              20.height,
                              Row(
                                children: [
                                  Container(height: 40, color: Colors.black38, width: MediaQuery.of(context).size.width * 0.6),
                                  20.width,
                                  Text(securityCodeCont.text, style: boldTextStyle(size: 24)),
                                ],
                              ),
                              20.height,
                              Container(height: 40, color: Colors.black12),
                            ],
                          ),
                        ),
                      ),
                    ),
                    40.height,
                    TextField(
                      controller: cardNumberCont,
                      keyboardType: TextInputType.number,
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        labelText: 'card Number',
                        counterText: '',
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF0A79DF))),
                        labelStyle: secondaryTextStyle(),
                      ),
                      maxLength: 16,
                      textInputAction: TextInputAction.next,
                      onChanged: (s) {
                        setState(() {});
                      },
                      onSubmitted: (s) {
                        FocusScope.of(context).requestFocus(expiryDateFocus);
                      },
                    ),
                    16.height,
                    Row(
                      children: [
                        ExpirationFormField(
                          controller: expiryDateCont,
                          style: primaryTextStyle(),
                          focusNode: expiryDateFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Expiry Date',
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF0A79DF))),
                            labelStyle: secondaryTextStyle(),
                            counterText: '',
                          ),
                        ).expand(),
                        // TextField(
                        //   controller: expiryDateCont,
                        //   keyboardType: TextInputType.datetime,
                        //   style: primaryTextStyle(),
                        //   focusNode: expiryDateFocus,
                        //   textInputAction: TextInputAction.next,
                        //   maxLength: 5,
                        //   decoration: InputDecoration(
                        //     labelText: 'Expiry Date',
                        //     border: OutlineInputBorder(),
                        //     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.red)),
                        //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF0A79DF))),
                        //     labelStyle: secondaryTextStyle(),
                        //     counterText: '',
                        //   ),
                        //   onChanged: (s) {
                        //     setState(() {});
                        //   },
                        //   onSubmitted: (s) {
                        //     FocusScope.of(context).requestFocus(securityCodeFocus);
                        //   },
                        // ).expand(),
                        16.width,
                        TextField(
                          controller: securityCodeCont,
                          keyboardType: TextInputType.number,
                          style: primaryTextStyle(),
                          focusNode: securityCodeFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Security Code',
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color:Colors.red)),
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF0A79DF))),
                            labelStyle: secondaryTextStyle(),
                            counterText: '',
                          ),
                          maxLength: 3,
                          onChanged: (s) {
                            setState(() {});
                          },
                          onSubmitted: (s) {
                            FocusScope.of(context).requestFocus(cardHolderFocus);
                          },
                        ).expand(),
                      ],
                    ),
                    16.height,
                    TextField(
                      controller: cardHolderCont,
                      textCapitalization: TextCapitalization.words,
                      focusNode: cardHolderFocus,
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        labelText: 'card Holder',
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF0A79DF))),
                        labelStyle: secondaryTextStyle(),
                      ),
                      onChanged: (s) {
                        setState(() {});
                      },
                    ),
                    20.height,
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
                      decoration: boxDecorationRoundedWithShadow(
                          gradient: LinearGradient(colors: [
                            Color(0xffE4B16C),
                            Color(0xffDE5D76),
                          ]),

                          8,),
                      child: Text('Proceed to Pay', style: boldTextStyle(color: white)),
                    ).onTap(() {
                      hideKeyboard(context);

                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Choose one', style: boldTextStyle()),
                                20.height,
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.green),
                                      alignment: Alignment.center,
                                      child: Text('Success', style: boldTextStyle(color: white)),
                                    ).onTap(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MLDashboardScreen()));
                                    }).expand(),
                                    16.width,
                                    Container(
                                      height: 60,
                                      decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.red),
                                      alignment: Alignment.center,
                                      child: Text('Fail', style: boldTextStyle(color: white)),
                                    ).onTap(() {

                                    }).expand(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
