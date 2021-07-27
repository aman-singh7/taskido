import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/services/firebase_auth_service.dart';
import 'package:task_dot_do/ui/base_landing_view.dart';
import 'package:task_dot_do/ui/login_view.dart';
import 'package:task_dot_do/validators.dart';
import 'package:task_dot_do/viewmodels/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  TextEditingController get nameController => _nameController;

  set nameController(nameController) {
    _nameController = nameController;
  }

  TextEditingController get emailController => _emailController;

  set emailController(emailController) {
    _emailController = emailController;
  }

  TextEditingController get passwordController => _passwordController;

  set passwordController(passwordController) {
    _passwordController = passwordController;
  }

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  set confirmPasswordController(confirmPasswordController) {
    _confirmPasswordController = confirmPasswordController;
  }

  void onModelReady() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void onModelDestroy() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  String? Function(String? name) get nameValidator => Validator.nameValidator;

  String? Function(String? email) get emailValidator =>
      Validator.emailValidator;

  String? Function(String? password) get passwordValidator =>
      Validator.passwordValidator;

  String? Function(String? confirmPassword) get confirmPasswordValidator =>
      (confirmPassword) {
        print(passwordController.text);
        return Validator.confirmPasswordValidator(
            confirmPassword, passwordController);
      };

  void login() {
    Get.offAllNamed(LoginView.id);
  }

  void register(keepSignedIn) async {
    try {
      await _firebaseAuthService.signUp(
        _nameController.text,
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
}
