import 'package:Autobound/models/index.dart';
import 'package:Autobound/styles/colors.dart';
import 'package:Autobound/widgets/app_form_item.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormRef = GlobalKey<FormState>();
  final _loginForm = LoginForm(email: '', password: '');

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _emailFieldKey.currentState?.validate();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _passwordFieldKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _login() {
    final isValid = _loginFormRef.currentState?.validate();
    if (isValid == true) {
      _loginFormRef.currentState?.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: 180,
                    height: 40,
                  ),
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
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                          focusNode: _passwordFocusNode,
                          placeholder: 'Enter Your Password',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.go,
                          validator: (value) => value!.isEmpty ? 'Password is required' : null,
                          onFieldSubmitted: (_) => _login(),
                          onSaved: (value) {
                            _loginForm.password = value ?? '';
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: CupertinoButton.filled(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(5),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        onPressed: _login),
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
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
