import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart' as dialog;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/MLColors.dart';
import '../../utils/MLImage.dart';
import '../../utils/MLString.dart';
import '../home/MLDashboardScreen.dart';
import '../nicu_chat/api/apis.dart';
import '../nicu_chat/helper/dialogs.dart';
import 'MLRegistrationScreen.dart';

class MLLoginScreen extends StatefulWidget {
  static String tag = '/MLLoginScreen';

  const MLLoginScreen({super.key});

  @override
  _MLLoginScreenState createState() => _MLLoginScreenState();
}

class _MLLoginScreenState extends State<MLLoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 250),
            height: context.height(),
            decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32)),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    60.height,
                    Text(mlLogin_title!, style: secondaryTextStyle(size: 16)),
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
                        prefixIcon: const Icon(Icons.person),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey),
                        ),
                      ),
                    ),
                    16.height,
                    AppTextField(
                      controller: pass,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: InputDecoration(
                        labelText: 'ادخل كلمه السر',
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: const Icon(Icons.lock_outline),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey),
                        ),
                      ),
                    ),
                    // 8.height,
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: Text(mlForget_password!,
                    //           style: secondaryTextStyle(size: 16))
                    //       .onTap(() {
                    //     MLForgetPasswordScreen().launch(context);
                    //   }),
                    // ),
                    24.height,
                    AppButton(
                      color: mlPrimaryColor,
                      width: double.infinity,
                      onTap: () async {
                        finish(context);
                        _submit();
                      },
                      child: Text(mlLogin!, style: boldTextStyle(color: white)),
                    ),
                    22.height,
                    Text(mlLogin_with!, style: secondaryTextStyle(size: 16))
                        .center(),
                    22.height,
                    InkWell(
                      onTap: () {
                        _handleGoogleBtnClick();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 8, left: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: radius(12),
                          border: Border.all(color: mlColorLightGrey),
                        ),
                        child: Image.asset(ml_ic_logo_google,
                            height: 24, width: 24),
                      ),
                    ),
                    22.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mlDont_have_account!,
                          style: primaryTextStyle(),
                        ),
                        8.width,
                        Text(
                          mlRegister!,
                          style: boldTextStyle(
                              color: mlColorBlue,
                              decoration: TextDecoration.underline),
                        ).onTap(() {
                          MLRegistrationScreen().launch(context);
                        }),
                      ],
                    ),
                    32.height,
                  ],
                ).paddingOnly(left: 16, right: 16),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 75),
            width: context.width(),
            child: Image.asset(
              ml_ic_register_indicator,
              alignment: Alignment.center,
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (formKey.currentState!.validate()) {
      var user = await login();
      if (user != null) {
        const MLDashboardScreen().launch(context);
      }
    } else {
      print('error');
      print('Not Valid');
    }

    // Sign user up
  }

  login() async {
    try {
      if (email.text.isNotEmpty && pass.text.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email.text, password: pass.text);
        return userCredential;
      } else {
        print('isEmpty');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dialog.AwesomeDialog(
          context: context,
          dialogType: dialog.DialogType.INFO,
          animType: dialog.AnimType.BOTTOMSLIDE,
          title: 'Attend  !',
          desc: 'This Account IsNot Exist',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'wrong-password') {
        dialog.AwesomeDialog(
          context: context,
          dialogType: dialog.DialogType.INFO,
          animType: dialog.AnimType.BOTTOMSLIDE,
          title: 'Attend  !',
          desc: 'The password is Wrong',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }

  // handles google login button click
  _handleGoogleBtnClick() {
    //for showing progress bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          const MLDashboardScreen().launch(context);
        } else {
          await APIs.createUser().then((value) {
            const MLDashboardScreen().launch(context);
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }
}
