import 'package:flutter/material.dart';
import 'package:partners_app/custom/signup_text_field.dart';
import 'package:partners_app/models/signup.dart';
import 'package:partners_app/providers/partners_provider.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> {
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _contactPersonController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _reachController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _signUp(BuildContext context, PartnersProivders pp) {
    int reach = int.tryParse(_reachController.value.text) ?? 0;
    if (reach == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sign up failed, reach must be numeric!'),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    pp
        .signUp(SignUp(
            businessName: _businessNameController.value.text,
            address: _addressController.value.text,
            phoneNumber: _phoneNumberController.value.text,
            contactPerson: _contactPersonController.value.text,
            email: _emailController.value.text,
            reach: reach,
            username: _usernameController.value.text,
            password: _passwordController.value.text))
        .then((response) {
      if (response == 200) {
        // Do a snack bar notification
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign up successful'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sign up failed, check your details and try again'),
        duration: Duration(seconds: 2),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('SIGN UP'),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 20),
          SignUpTextField(
              icon: const Icon(Icons.business),
              hint: 'Enter your business name',
              controller: _businessNameController,
              isPassword: false),
          SignUpTextField(
              icon: const Icon(Icons.location_on),
              hint: 'Enter your address',
              controller: _addressController,
              isPassword: false),
          SignUpTextField(
              icon: Icon(Icons.phone),
              hint: 'Enter your phone number',
              controller: _phoneNumberController,
              isPassword: false),
          SignUpTextField(
              icon: const Icon(Icons.person_4),
              hint: 'Enter your contact person',
              controller: _contactPersonController,
              isPassword: false),
          SignUpTextField(
              icon: const Icon(Icons.email),
              hint: 'Enter your email',
              controller: _emailController,
              isPassword: false),
          SignUpTextField(
              icon: const Icon(Icons.group),
              hint: 'Enter your reach',
              controller: _reachController,
              isPassword: false),
          SignUpTextField(
              icon: const Icon(Icons.person),
              hint: 'Enter your username',
              controller: _usernameController,
              isPassword: false),
          SignUpTextField(
              icon: const Icon(Icons.lock),
              hint: 'Enter your password',
              controller: _passwordController,
              isPassword: true),
          Consumer<PartnersProivders>(
              builder: (context, partnersProvider, child) {
            return ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () {
                  _signUp(context, partnersProvider);
                });
          })
        ],
      )),
    );
  }
}
