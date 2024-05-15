import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String content) {
  SnackBar snackBar = SnackBar(content: Text(content));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
