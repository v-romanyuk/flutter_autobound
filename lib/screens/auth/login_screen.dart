import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Autobound/models/models.dart';
import 'package:Autobound/services/services.dart';
import 'package:Autobound/styles/colors.dart';
import 'package:Autobound/widgets/app_form_item.dart';
import 'package:email_validator/email_validator.dart';

import 'package:Autobound/screens/suggested_campaigns/suggested_campaigns_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  final _scrollController = ScrollController();
  final _loginFormRef = GlobalKey<FormState>();
  final _loginForm = LoginForm(email: '', password: '');

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();

  void _animateToLoginButton() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.animateTo(
      100,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() async {
      if (!_emailFocusNode.hasFocus) {
        _emailFieldKey.currentState?.validate();
      } else {
        _animateToLoginButton();
      }
    });
    _passwordFocusNode.addListener(() async {
      if (!_passwordFocusNode.hasFocus) {
        _passwordFieldKey.currentState?.validate();
      } else {
        _animateToLoginButton();
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _login() async {
    final isValid = _loginFormRef.currentState?.validate();

    if (isValid == true) {
      _loginFormRef.currentState?.save();

      try {
        setState(() {
          _loading = true;
        });
        final a = await http.post('auth/login', body: _loginForm.toJson());
        Navigator.of(context).pushReplacementNamed(SuggestedCampaignsScreen.routeName);
      }
      finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 15, top: 90, bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'lib/assets/images/logo.png',
                  width: 180,
                  height: 40,
                ),
                Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Welcome back!',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      'Please login with your account.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Form(
                    key: _loginFormRef,
                    child: Column(
                      children: [
                        AppFormItem(
                          key: _emailFieldKey,
                          enabled: !_loading,
                          focusNode: _emailFocusNode,
                          initialValue: 'dev@dev.dev',
                          keyboardType: TextInputType.emailAddress,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          placeholder: 'Enter Your Email',
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return EmailValidator.validate(value) ? null : 'Please enter a valid email';
                            } else {
                              return 'Email is required';
                            }
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          onSaved: (value) {
                            _loginForm.email = value ?? '';
                          },
                        ),
                        AppFormItem(
                          key: _passwordFieldKey,
                          enabled: !_loading,
                          focusNode: _passwordFocusNode,
                          initialValue: 'dev@dev.dev',
                          placeholder: 'Enter Your Password',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          textInputAction: TextInputAction.go,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            } else if (value.length <= 8) {
                              return 'Password is too short';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (_) => _login(),
                          onSaved: (value) {
                            _loginForm.password = value ?? '';
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: CupertinoButton.filled(
                      disabledColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(5),
                      child: _loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                      onPressed: _loading ? null : _login,
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.primary))),
                      child: CupertinoButton(
                          minSize: 0,
                          padding: EdgeInsets.zero,
                          child: const Text(
                            'Contact sales',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () => {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
