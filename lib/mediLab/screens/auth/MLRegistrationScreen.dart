import 'package:awesome_dialog/awesome_dialog.dart' as dialog;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/MLColors.dart';
import '../../utils/MLCommon.dart';
import '../../utils/MLImage.dart';
import '../../utils/MLString.dart';
import '../MLConfirmPhoneNumberScreen.dart';
import '../home/MLDashboardScreen.dart';

class MLRegistrationScreen extends StatefulWidget {
  static String tag = '/MLRegistrationScreen';

  const MLRegistrationScreen({super.key});

  @override
  _MLRegistrationScreenState createState() => _MLRegistrationScreenState();
}

class _MLRegistrationScreenState extends State<MLRegistrationScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  CollectionReference? addUser;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 250),
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32)),
              height: context.height(),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      48.height,
                      Text(mlRegister!, style: boldTextStyle(size: 28)),
                      8.height,
                      Text('ادخل بياناتك..',
                          style: secondaryTextStyle(size: 16)),
                      16.height,
                      AppTextField(
                        textFieldType: TextFieldType.EMAIL,
                        controller: name,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'ادخل بيانات صحيحه ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'ادخل اسمك ',
                          labelStyle: secondaryTextStyle(size: 16),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mlColorLightGrey),
                          ),
                        ),
                      ),
                      16.height,
                      AppTextField(
                        textFieldType: TextFieldType.EMAIL,
                        controller: phone,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'ادخل رقم الهاتف ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'ادخل رقم الهاتف ',
                          labelStyle: secondaryTextStyle(size: 16),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mlColorLightGrey),
                          ),
                        ),
                      ),
                      16.height,
                      AppTextField(
                        textFieldType: TextFieldType.EMAIL,
                        controller: email,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'ادخل بيانات صحيحه ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'ادخل البريد الالكتروني',
                          labelStyle: secondaryTextStyle(size: 16),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mlColorLightGrey),
                          ),
                        ),
                      ),
                      16.height,
                      AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        controller: pass,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'ادخل بيانات صحيحه ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: mlPassword!,
                          labelStyle: secondaryTextStyle(size: 16),
                          prefixIcon: const Icon(Icons.lock_outline, size: 20),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mlColorLightGrey),
                          ),
                        ),
                      ),
                      16.height,
                      AppTextField(
                        controller: cPass,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'ادخل بيانات صحيحه ';
                          }
                          return null;
                        },
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: InputDecoration(
                          labelText: mlReenter_password!,
                          labelStyle: secondaryTextStyle(size: 16),
                          prefixIcon: const Icon(Icons.lock_outline, size: 20),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mlColorLightGrey),
                          ),
                        ),
                      ),
                      32.height,
                      AppButton(
                        width: double.infinity,
                        color: mlPrimaryColor,
                        onTap: () {
                          _submit();
                        },
                        child: Text(mlRegister!,
                            style: boldTextStyle(color: white)),
                      ),
                      20.height,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 75),
              width: double.infinity,
              child: Image.asset(
                ml_ic_register_indicator!,
                alignment: Alignment.center,
                width: 200,
                height: 200,
              ),
            ),
            Positioned(
              top: 30,
              child: mlBackToPrevious(context, whiteColor),
            ),
          ],
        ).center(),
      ),
    );
  }

  void _submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      UserCredential response = await signUp();
      User? userID = FirebaseAuth.instance.currentUser;
      setState(() {
        user = userID;
      });
      const MLDashboardScreen().launch(context);
      await addDataEmail();
      return;
    }
  }

  signUp() async {
    try {
      if (email.text.isNotEmpty &&
          pass.text.isNotEmpty &&
          cPass.text.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: pass.text);
        return userCredential;
      } else {}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        dialog.AwesomeDialog(
          context: context,
          dialogType: dialog.DialogType.INFO,
          animType: dialog.AnimType.BOTTOMSLIDE,
          title: 'Attend  !',
          desc: 'The password is weak',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'email-already-in-use') {
        dialog.AwesomeDialog(
          context: context,
          dialogType: dialog.DialogType.INFO,
          animType: dialog.AnimType.BOTTOMSLIDE,
          title: 'Attend  !',
          desc: 'This Account is Already Exist',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }

  addDataEmail() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    addUser = FirebaseFirestore.instance.collection('users');
    addUser?.doc('${user?.uid}').set({
      'email': email.text,
      'name': name.text,
      'isUser':true,
      'Phone': phone.text,
      'id': user?.uid,
      'image': 'null',
      'created_at': time,
      'is_online': false,
      'last_active': time,
      'push_token': '',
      'about': 'Hallo'
    });
  }
}
