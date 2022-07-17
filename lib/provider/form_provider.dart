import 'package:flutter/cupertino.dart';
import 'package:lista_tareas/models/models.dart';

//Proviver para el formulario
class FromProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Tarea tarea;
  //get y set para el cambio de estado de la tarea en formulario
  bool _terminar = false;
  bool get terminar => _terminar;
  set terminar(bool valor) {
    _terminar = valor;
    terminar ? tarea.isCompleted = 1 : tarea.isCompleted = 0;

    notifyListeners();
  }

//tarea que recibe para editar o guardar
  FromProvider(this.tarea);
//funcion para verificar si las validaciones estan complidas
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
