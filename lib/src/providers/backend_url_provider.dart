import 'package:flutter/material.dart';

class BackendURLProvider extends ChangeNotifier {
  String _backendURL = 'http://127.0.0.1:8000/api/v1/';

  String get backendURL => _backendURL;

  set backendURL(String value) {
    _backendURL = value;
    notifyListeners();
  }
}
