import 'package:html/parser.dart';
import 'package:flutter/material.dart';
Widget customFormField(
    {required TextEditingController controller,
    bool obscureText = false,
    required String labelText,
    Icon? prefixIcon,
    Icon? suffixIcon,
    String? Function(String?)? validator}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

String convertHtmlToPlainText(String htmlString) {
  final document = parse(htmlString);
  return document.body?.text.trim() ?? "";
}