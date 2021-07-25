import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/ui/components/custom_text_field.dart';

class DialogService {
  Future<String> showForgetPasswordDialog() async {
    var _emailController = TextEditingController();
    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Forgot Passowrd'),
              SizedBox(height: 10),
              CustomTextField(
                _emailController,
                'Email',
                'Enter your email',
                Icons.email,
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: AppTheme.primary,
                onPressed: () => Get.key.currentState!.pop(),
                child: Text(
                  'Send Email',
                  style: AppTheme.button,
                ),
              )
            ],
          ),
        ),
      ),
    );
    return _emailController.text;
  }
}
