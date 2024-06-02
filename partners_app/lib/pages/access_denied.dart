import 'package:flutter/material.dart';
import 'package:partners_app/pages/login_page.dart';

class AccessDenied extends StatelessWidget {
  const AccessDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Login Page'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              const Text("Access Denied. Please login to access this page."),
              FloatingActionButton(
                child: const Text('Login'),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()))
                },
              )
            ])));
  }
}
