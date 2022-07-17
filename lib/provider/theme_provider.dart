import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  //Get y Set para el combio de tema de la aplicacion
  bool _tema = false;

  bool get tema => _tema;

  set tema(bool valor) {
    _tema = valor;

    notifyListeners();
  }
}
