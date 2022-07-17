import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  //Get  y Set para el cambio de tema de la aplicación
  bool _tema = false;

  bool get tema => _tema;

  set tema(bool valor) {
    _tema = valor;

    notifyListeners();
  }
}
