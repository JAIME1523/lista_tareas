import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/models.dart';

//Proider para la conexion con la api
class TareasProvider extends ChangeNotifier {
  TareasProvider() {
    consultaLista();
  }
//constantes para el llamado de la api
  static const String _url = 'ecsdevapi.nextline.mx';
  static const String _token =
      'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
  final _header = {
    "Content-type": "application/json",
    'Accept': 'application/json',
    "Authorization": "Bearer $_token"
  };
  static const _params = {
    'token': _token,
  };

  final url = Uri.https(_url, 'vdev/tasks-challenge/tasks', _params);
  bool cargar = true;
//lista para en la que agregaran todos las tareas tridas desde api
  final List<Tarea> tareasLista = [];
// variable para asignar cundo se llame una sola tarea desde la api
  Tarea tarea = Tarea();

//llamado de la api, donde se traen todas las tareas y se asignan a la lista "tareasLista"
  consultaLista() async {
    try {
      final resp = await http.get(
        url,
        headers: _header,
      );
      var resul = json.decode(resp.body);
      for (var i = 0; i < resul.length; i++) {
        var tareaTemp = Tarea.fromMap(resul[i]);
        tareasLista.add(tareaTemp);
      }
      notifyListeners();
    } catch (e) {
      return e;
    }
  }

//Funcion para agregar una nueva tarea, recibe una variable de tipo "Tarea", la cual es decodificada,para enviar a la api
  agregarTarea(Tarea tarea) async {
    cargar = false;
    notifyListeners();
    tarea.token = _token;
    try {
      final resp = await http.post(url,
          headers: _header, body: json.encode(tarea.toMap()));
      var result = json.decode(resp.body);

      if (resp.statusCode == 201 || resp.statusCode == 200) {
        //una vez registrada la api regresa la tarea registrada y es agregada a la lista "tareasLista"
        var tareaTemp = Tarea.fromMap(result['task']);
        tareasLista.add(tareaTemp);
        notifyListeners();
      }
    } catch (e) {
      return e;
    }
    cargar = true;
    notifyListeners();
  }

//funcion recibe una tarea y  elimina desde la API la tarea por id
  eliminarTarea(Tarea tareaEliminar) async {
    try {
      final resp = await http.delete(
        Uri.https(
            _url, 'vdev/tasks-challenge/tasks/${tareaEliminar.id}', _params),
        headers: _header,
      );
      if (resp.statusCode == 201 || resp.statusCode == 200) {
        //si el proceso se realiza, subusca el id de la taraea en la lista "tareaLista" para removerla
        for (var element in tareasLista) {
          if (element.id == tareaEliminar.id) {
            tareasLista.remove(tareaEliminar);
            notifyListeners();
          }
        }
      }
    } catch (e) {
      return e;
    }
  }

//Busca una tarea por id en espesifico donde trae todos sus datos, poder mostrarlo en la vista
  traerTarea(int id) async {
    try {
      final resp = await http.get(
          Uri.https(_url, 'vdev/tasks-challenge/tasks/$id', _params),
          headers: _header);
      var result = json.decode(resp.body);

      tarea = Tarea.fromMap(result[0]);
      notifyListeners();
    } catch (e) {
      return e;
    }
  }

//actulizar la tarea por id, recibe la tarea a editada y se ejecuata un put con el id de la tarea
  editarTarea(Tarea editarTarea) async {
    cargar = false;

    tarea.token = _token;
    try {
      final resp = await http.put(
          Uri.https(_url, 'vdev/tasks-challenge/tasks/${editarTarea.id}'),
          headers: _header,
          body: json.encode(tarea.toMap()));
      // var result = json.decode(resp.body);

      if (resp.statusCode == 201 || resp.statusCode == 200) {
        for (var i = 0; i < tareasLista.length; i++) {
          if (tareasLista[i].id == editarTarea.id) {
            //sebusca dentro de la lista "tareasLista" el id de la tarea editada y se iguala en la lista
            tareasLista[i] = editarTarea;
            notifyListeners();
          }
        }
      }
    } catch (e) {
      return e;
    }
    cargar = true;
    notifyListeners();
  }
}
