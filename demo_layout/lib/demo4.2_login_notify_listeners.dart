import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  String _submittedFullname = "";
  String _submittedAlias = "";
  int _counter = 0;

  String get fullname => _submittedFullname;
  String get alias => _submittedAlias;
  int get counter => _counter;

  void submit(String fullname, String alias) {
    _submittedFullname = fullname;
    _submittedAlias = alias;
    _counter++;
    notifyListeners();
  }
}


final countNotifier = ValueNotifier<int>(0);