import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  

   bool _tema = false;

  bool get tema => _tema;

  set tema(bool valor) {
    _tema = valor;

    notifyListeners();
  }
}
