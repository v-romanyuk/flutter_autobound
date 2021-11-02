import 'package:Autobound/models/models.dart';
import 'package:Autobound/providers.dart';
import 'package:Autobound/screens/auth/widgets/contact_sales.dart';
import 'package:Autobound/screens/suggested_campaigns/suggested_campaigns_screen.dart';
import 'package:Autobound/styles/colors.dart';
import 'package:Autobound/widgets/app_form_item.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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

        await context.read<AuthProvider>().login(_loginForm);
        Navigator.of(context).pushReplacementNamed(SuggestedCampaignsScreen.routeName);
      } on DioError catch (_) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Incorrect email or password.'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                child: const Text('Try Again'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      } finally {
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
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'lib/assets/images/logo.png',
                  width: 260,
                  height: 52,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        'Login to Autobound',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Form(
                      key: _loginFormRef,
                      child: Column(
                        children: [
                          AppFormItem(
                            key: _emailFieldKey,
                            label: 'Email',
                            labelIcon: FontAwesomeIcons.solidEnvelope,
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
                            label: 'Password',
                            labelIcon: FontAwesomeIcons.lock,
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
                    Container(
                      width: double.infinity,
                      height: 36,
                      margin: const EdgeInsets.only(bottom: 20),
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

                    const ContactSale()
                  ]),
                ),
                Text('© 2021 Autobound.ai', style: TextStyle(
                  color: AppColors.white.withOpacity(0.65),
                  fontSize: 12
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
