import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController snackbarWidget(
    {var image, required String title, required String subtitle}) {
  return Get.snackbar(
    icon: Image.asset(image),
    "Successful!",
    "Your check out completed successfully!",
    duration: const Duration(
      milliseconds: 1500,
    ),
    backgroundColor: Colors.white,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
    borderRadius: 10,
    borderColor: Colors.blue,
    borderWidth: 3,
    titleText: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
    messageText: Text(
      subtitle,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
  );
}
