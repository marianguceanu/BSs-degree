import 'package:flutter/material.dart';
import 'package:partners_app/custom/custom_text_field.dart';
import 'package:partners_app/models/user.dart';
import 'package:partners_app/pages/access_denied.dart';
import 'package:partners_app/pages/main_page.dart';
import 'package:partners_app/pages/signup_page.dart';
import 'package:partners_app/services/partner_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<int> _login() async {
    User user = User(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    return await partnerService.login(user);
  }

  Future<int> _validateToken() async {
    int responseCode = await partnerService.validateToken();
    return responseCode;
  }

  Future<void> _loginProcess(BuildContext context) async {
    _login().then((value) => {
          if (value == 200)
            {
              _validateToken().then((value) => {
                    if (value != 200)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccessDenied()),
                        )
                      }
                  }),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              )
            }
          else
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccessDenied()),
              )
            }
        });
  }

  void _goToSignup(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('PARTNERS APP'),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      // Username text field
                      CustomTextField(
                          controller: _usernameController,
                          label: 'Username',
                          hint: 'Enter your username',
                          isTextObscured: false),
                      const SizedBox(height: 25),

                      // Password text field
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Enter your password',
                        isTextObscured: true,
                      ),
                      const SizedBox(height: 25),

                      // Login button
                      FloatingActionButton(
                          onPressed: () => {_loginProcess(context)},
                          child: const Text('Login')),

                      // Go to sign up page
                      Row(
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                _goToSignup(context);
                              },
                              child: const Text('Sign up'))
                        ],
                      )
                    ],
                  )),
            ]),
      ),
    );
  }
}
