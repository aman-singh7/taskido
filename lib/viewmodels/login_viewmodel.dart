import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/ui/base_landing_view.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

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

  void forgetPassword() {
    //implement forget password
    debugPrint('Forget Password Clicked!');
  }

  void createAccount() {
    //route to register page
    debugPrint('Create Account');
  }

  void login(bool keepSignedIn) {
    //implement login logic
    debugPrint('Email : ${_emailController.text}');
    debugPrint('Password : ${_passwordController.text}');
    debugPrint('keepSignedIn : $keepSignedIn');
    Get.offAllNamed(BaseLandingView.id);
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password field is required';
    } else if (password.length < 6) {
      return "Password can't be smaller than 6 characters";
    } else {
      return null;
    }
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email field is required';
    } else if (!GetUtils.isEmail(email.trim())) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }
}
