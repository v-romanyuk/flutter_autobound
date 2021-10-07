import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import '../../models/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordFocusNode = FocusNode();
  final _loginFormRef = GlobalKey<FormState>();
  final _loginForm = LoginForm(email: '', password: '');

  void _login () {
    final isValid = _loginFormRef.currentState?.validate();
    if (isValid == true) {
      _loginFormRef.currentState?.save();
      print(_loginForm.email);
    }
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        width: double.infinity,
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
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  'Welcome back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
              ),
              const Text(
                'Please login with your account.',
                style: TextStyle(fontSize: 18),
              ),
              Form(
                key: _loginFormRef,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    CupertinoTextFormFieldRow(
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
                    CupertinoTextFormFieldRow(
                      placeholder: 'Enter Your Password',
                      obscureText: true,
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      validator: (value) => value!.isEmpty ? 'Password is required' : null,
                      onFieldSubmitted: (_) => _login(),
                      onSaved: (value) {
                        _loginForm.password = value ?? '';
                      },
                    )
                  ],
                ),
              ),
            ]),
            Text('teasdf')
          ],
        ),
      ),
    );
  }
}
