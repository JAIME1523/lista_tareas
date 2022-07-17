import 'package:flutter/cupertino.dart';
import 'package:lista_tareas/models/models.dart';

class FromProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Tarea tarea ;

  bool valorVista = false;

  bool _terminar = false;

  bool get terminar => _terminar;

  set terminar(bool valor) {
    _terminar = valor;
    terminar ? tarea.isCompleted = 1 : tarea.isCompleted = 0;

    notifyListeners();
  }

  FromProvider(this.tarea);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
