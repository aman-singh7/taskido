import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Validator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name field is empty';
    } else {
      return null;
    }
  }

  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email field is required';
    } else if (!GetUtils.isEmail(email.trim())) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password field is required';
    } else if (password.length < 6) {
      return "Password can't be smaller than 6 characters";
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(
      String? confirmPassword, TextEditingController passwordController) {
    print('${passwordController.text} in Validator');
    print(confirmPassword);
    if (confirmPassword == null || confirmPassword.isEmpty) {
      print('Field is empty');
      return 'Confirm Password field is required';
    } else if (confirmPassword != passwordController.text) {
      return "It doesn't matches with password";
    } else {
      return null;
    }
  }

  static String? validateTextField(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required Field';
    }
    return null;
  }
}
