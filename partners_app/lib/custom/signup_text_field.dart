import 'package:flutter/material.dart';

class SignUpTextField extends StatefulWidget {
  final String hint;
  TextEditingController controller;
  final bool isPassword;
  final Widget icon;

  SignUpTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.isPassword,
    required this.icon,
  });

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              hintText: widget.hint,
              contentPadding: const EdgeInsets.all(10.0),
              border: const OutlineInputBorder(),
              suffixIcon: widget.icon,
            ),
          ),
        ),
      ],
    );
  }
}
