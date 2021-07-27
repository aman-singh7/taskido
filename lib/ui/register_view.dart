import 'package:flutter/material.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/register_viewmodel.dart';

import 'components/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  static const String id = 'register_view';
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formkey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _keepSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      onModelReady: (model) => model.onModelReady(),
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset('assets/images/top-right-loginPage.png'),
              ),
              _buildRegisterForm(model),
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/images/bottom-left-loginPage.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm(RegisterViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: _formkey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text('Sign Up', style: AppTheme.headline1),
              SizedBox(height: 40),
              _buildNameTextField(model),
              SizedBox(height: 20),
              _buildEmailTextField(model),
              SizedBox(height: 20),
              _buildPasswordTextField(model),
              SizedBox(height: 20),
              _buildConfirmPasswordTextField(model),
              _buildLogInButton(model),
              _buildKeepSignedInCheckBox(),
              _buildRegisterButton(model, _keepSignedIn),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField(RegisterViewModel model) {
    return CustomTextField(
      model.nameController,
      'Name',
      'Enter your name',
      Icons.person,
      validator: model.nameValidator,
    );
  }

  Widget _buildEmailTextField(RegisterViewModel model) {
    return CustomTextField(
      model.emailController,
      'Email',
      'Enter your email',
      Icons.email,
      validator: model.emailValidator,
    );
  }

  Widget _buildPasswordTextField(RegisterViewModel model) {
    return CustomTextField(
      model.passwordController,
      'Password',
      'Enter your password',
      Icons.lock,
      isHidden: _isHidden,
      validator: model.passwordValidator,
      suffix: IconButton(
        icon: _isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        onPressed: () {
          setState(() {
            _isHidden = !_isHidden;
          });
        },
      ),
    );
  }

  Widget _buildConfirmPasswordTextField(RegisterViewModel model) {
    return CustomTextField(
      model.confirmPasswordController,
      'Confirm Password',
      'Again Enter your password',
      Icons.lock,
      isHidden: true,
      validator: model.confirmPasswordValidator,
    );
  }

  Widget _buildLogInButton(RegisterViewModel model) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: model.login,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          'Already have an account?',
          style: AppTheme.bodyText1.copyWith(color: AppTheme.primary),
        ),
      ),
    );
  }

  Widget _buildKeepSignedInCheckBox() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      activeColor: AppTheme.primary,
      title: Text('Keep me signed in'),
      value: _keepSignedIn,
      onChanged: (value) {
        setState(() {
          _keepSignedIn = value!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildRegisterButton(RegisterViewModel model, keepSignedIn) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppTheme.primary,
              textStyle: AppTheme.button,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onPressed: () => _formkey.currentState!.validate()
                ? model.register(keepSignedIn)
                : null,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Sign Up'),
            ),
          ),
        ),
      ],
    );
  }
}
