import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.isTextObscured,
    required this.icon,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isTextObscured;
  final Icon icon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label,
            hintText: widget.hint,
            suffixIcon: widget.icon,
          ),
          cursorWidth: 2,
          obscureText: widget.isTextObscured,
          style: const TextStyle(color: Colors.black),
          controller: widget.controller,
        ));
  }
}
