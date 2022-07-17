import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

import '../models/models.dart';

class TareasProvider extends ChangeNotifier {
  TareasProvider() {
    consultaLista();
  }

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

  bool cargar = true;

  final url = Uri.https(_url, 'vdev/tasks-challenge/tasks', _params);

  final List<Tarea> tareasLista = [];
  Tarea tarea = Tarea();

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

  agregarTarea(Tarea tarea) async {
    cargar = false;
    notifyListeners();

    tarea.token = _token;
    try {
      final resp = await http.post(url,
          headers: _header, body: json.encode(tarea.toMap()));
      var result = json.decode(resp.body);

      if (resp.statusCode == 201 || resp.statusCode == 200) {
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

  eliminarTarea(Tarea tareaEliminar) async {
    try {
      final resp = await http.delete(
          Uri.https(
              _url, 'vdev/tasks-challenge/tasks/${tareaEliminar.id}', _params),
          headers: _header,
          );
      if (resp.statusCode == 201 || resp.statusCode == 200) {
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
