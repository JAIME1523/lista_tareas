import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lista_tareas/models/models.dart';
import 'package:lista_tareas/provider/provider.dart';
import 'package:lista_tareas/screen/screen.dart';
import 'package:lista_tareas/style/style.dart';

class DatosListaScreen extends StatelessWidget {
  const DatosListaScreen(
      {Key? key, required this.tarea, required this.tareaProvider})
      : super(key: key);

  final Tarea tarea;
  final TareasProvider tareaProvider;

  @override
  Widget build(BuildContext context) {
    return tarea.title == null
        ? const CircularProgressIndicator()
        : Container(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: _Card(
              tareaProvider: tareaProvider,
              tarea: tarea,
            ));
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.tarea,
    required this.tareaProvider,
  }) : super(key: key);
  final Tarea tarea;
  final TareasProvider tareaProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      color: Colors.blue[100],
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tarea.isCompleted == 1 ? 'Completada' : 'Pendiente',
                      style: TextDatosLista.style2),
                  Icon(
                      tarea.isCompleted == 1
                          ? FontAwesomeIcons.check
                          : FontAwesomeIcons.spinner,
                      color: tarea.isCompleted == 1
                          ? Colors.green
                          : Colors.yellow),
                         const SizedBox(height: 15,),
                          ElevatedButton(
                            style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                            onPressed: (() {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FormularioScreen(
                                      tarea: tarea,
                                      tareaProvider: tareaProvider,
                                      funcion: 'Editar',
                                    )));
                          }), child:const Text('Editar'))
                
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Titulo:", style: TextDatosLista.style2),
                  Text(
                    tarea.title!,
                    style: TextDatosLista.style1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Fecha vencimiento:", style: TextDatosLista.style2),
                  Text(
                    tarea.dueDate ?? 'sin fecha',
                    style: TextDatosLista.style1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Comentarios:", style: TextDatosLista.style2),
                  Text(
                    tarea.comments ?? 'sin comentarios',
                    style: TextDatosLista.style1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Comentarios:", style: TextDatosLista.style2),
                  Text(
                    tarea.description ?? 'sin descripcion',
                    style: TextDatosLista.style1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Tags:", style: TextDatosLista.style2),
                  Text(
                    tarea.tags ?? 'sin tags',
                    style: TextDatosLista.style1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
