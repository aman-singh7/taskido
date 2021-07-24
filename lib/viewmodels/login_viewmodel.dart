import 'package:flutter/material.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  void onModelReady() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  void forgetPassword() {
    debugPrint('Forget Password Clicked!');
    //implement forget password
  }

  void createAccount() {
    debugPrint('Create Account');
    //route to register page
  }

  void login(bool keepSignedIn) {
    //implement login logic
    debugPrint('Email : ${_emailController.text}');
    debugPrint('Password : ${_passwordController.text}');
    debugPrint('keepSignedIn : $keepSignedIn');
  }

  String? passwordValidator(String? password) {
    if (password == null) {
      return "Password field can't be empty";
    } else if (password.length < 6) {
      return 'Password length should be more than 6';
    } else {
      return null;
    }
  }
}
