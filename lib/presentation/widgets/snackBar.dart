import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String message;

  CustomSnackBar({super.key, required this.message})
      : super(
    content: Text(message),
    // backgroundColor: Colors.green,
    duration: const Duration(milliseconds: 1000)// Change this to your desired color
  );
}
