import 'package:flutter/material.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/components/custom_text_field.dart';
import 'package:task_dot_do/viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  static const String id = 'login_view';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _keepSignedIn = false;
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) => model.onModelReady(),
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/images/top-right-loginPage.png'),
                ),
                _buildLoginForm(model),
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
      ),
    );
  }

  Widget _buildLoginForm(LoginViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign In', style: AppTheme.headline1),
            SizedBox(height: 40),
            _buildEmailTextField(model),
            SizedBox(height: 20),
            _buildPasswordTextField(model),
            _buildForgetPasswordButton(model),
            _buildKeepSignedInCheckBox(),
            _buildCreateAccountButton(model),
            SizedBox(height: 10),
            _buildLoginButton(model, _keepSignedIn),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField(LoginViewModel model) {
    return CustomTextField(
      model.emailController,
      'Email',
      'Enter your email',
      Icons.email,
      validator: model.emailValidator,
    );
  }

  Widget _buildPasswordTextField(LoginViewModel model) {
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

  Widget _buildForgetPasswordButton(LoginViewModel model) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: model.forgetPassword,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          'Forgot Password?',
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

  Widget _buildCreateAccountButton(LoginViewModel model) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: model.createAccount,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          "Don't have an account? Create one",
          style: AppTheme.bodyText1.copyWith(color: AppTheme.primary),
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginViewModel model, bool keepSignedIn) {
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
                ? model.login(keepSignedIn)
                : null,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Log In'),
            ),
          ),
        ),
      ],
    );
  }
}
