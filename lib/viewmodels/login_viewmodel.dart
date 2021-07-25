import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/services/firebase_auth_service.dart';
import 'package:task_dot_do/ui/base_landing_view.dart';
import 'package:task_dot_do/ui/register_view.dart';
import 'package:task_dot_do/validators.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';
import 'package:task_dot_do/services/dialog_service.dart';

class LoginViewModel extends BaseViewModel {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final TextEditingController forgotPasswordEmailController =
      TextEditingController();
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  void onModelReady() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void onModelDestroy() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get forgotPasswordDialogController =>
      forgotPasswordEmailController;

  void forgetPassword() async {
    final _dialogService = locator<DialogService>();
    var email = await _dialogService.showForgetPasswordDialog();
    // if (email == null) {
    //   print('null');
    // } else {
    //   print('email is $email');
    // }
  }

  void createAccount() {
    Get.offAllNamed(RegisterView.id);
    debugPrint('Create Account');
  }

  void login(bool keepSignedIn) async {
    debugPrint('Email : ${_emailController.text}');
    debugPrint('Password : ${_passwordController.text}');
    debugPrint('keepSignedIn : $keepSignedIn');
    try {
      var user = await _firebaseAuthService.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (keepSignedIn) {
        isLoggedIn = true;
      }

      await Get.offAndToNamed(BaseLandingView.id);
    } catch (e) {
      Get.snackbar(
        '',
        '',
        colorText: AppTheme.white,
        messageText: Center(
          child: Text(
            '$e',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.white),
          ),
        ),
        titleText: Container(),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        margin: EdgeInsets.all(20),
        backgroundColor: Color(0xcc333333),
        borderRadius: 40,
      );
    }
  }

  String? Function(String? password) get passwordValidator =>
      Validator.passwordValidator;

  String? Function(String? email) get emailValidator =>
      Validator.emailValidator;
}
