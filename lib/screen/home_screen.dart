import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lista_tareas/models/models.dart';
import 'package:lista_tareas/provider/provider.dart';
import 'package:lista_tareas/screen/screen.dart';
import 'package:lista_tareas/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
//se agrega el provider de tareas_provider
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TareasProvider(), child: const _ContenidoHome());
  }
}

//se manda a llamar los provider de lista_tareas para listar todas las tareas y theme_provider para cambiar el tema de la aplicaion
class _ContenidoHome extends StatelessWidget {
  const _ContenidoHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tareaProvider = Provider.of<TareasProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Column(
            children: [
              const Text('Tema'),
              //Switch para el combio de tema
              CupertinoSwitch(
                  trackColor: const Color.fromARGB(255, 1, 153, 255),
                  value: themeProvider.tema,
                  onChanged: (valor) {
                    themeProvider.tema = valor;
                  }),
            ],
          ),
        ],
        title: const Center(child: Text('Lista tareas')),
      ),
      body: tareaProvider.tareasLista.isEmpty
          ? const Center(
              child: Text('No hay datos'),
            )
          //FadeInLeft de la libreria "animate_do" para la animacion de la lista,
          : FadeInLeft(
              //Listar todas las tareas que estan en el arreglo "tareasLista"
              child: ListView.separated(
                separatorBuilder: (_, i) => const Divider(),
                physics: const BouncingScrollPhysics(),
                itemCount: tareaProvider.tareasLista.length,
                itemBuilder: (BuildContext context, int index) {
                  return _Lista(tarea: tareaProvider.tareasLista[index]);
                },
              ),
            ),
      floatingActionButton: const _FloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//Contenido del FloatingActionButtonLocation de la vista home
class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tareaProvider = Provider.of<TareasProvider>(context);
    //FloatingActionButton para agregar nueva tarea
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return FormularioScreen(
            tarea: Tarea(isCompleted: 0),
            tareaProvider: tareaProvider,
            funcion: 'Agregar',
          );
        }));
      },
      label: const Text('Agregar'),
      icon: const Icon(FontAwesomeIcons.plus),
    );
  }
}

//Contenido para cada elemento en la lista de tareas
class _Lista extends StatelessWidget {
  const _Lista({Key? key, required this.tarea}) : super(key: key);
  final Tarea tarea;

  @override
  Widget build(BuildContext context) {
    final listaPriver = Provider.of<TareasProvider>(context);
//GestureDetector dirije a la vista donde se mutran todos los datos de una sola tarea
    return GestureDetector(
      onTap: () async {
        await listaPriver.traerTarea(tarea.id!);
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DatosListaScreen(
              tarea: listaPriver.tarea,
              tareaProvider: listaPriver,
            );
          },
        );
      },
      child:
          //Dismissible permite arrastar un elemento de lista para poder eliminarlo con la funcion "eliminarTarea"
          Dismissible(
        key: Key('${tarea.id}'),
        direction: DismissDirection.startToEnd,
        onDismissed: (DismissDirection direction) async {
          if (direction == DismissDirection.startToEnd) {
            await listaPriver.eliminarTarea(tarea);
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Se elimino la tarea')));
          }
        },
        confirmDismiss: (DismissDirection direction) async {
          return await showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialogDelete();
            },
          );
        },
        background: Container(
          padding: const EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Borrar tarea', style: TextStyle(color: Colors.white)),
          ),
        ),
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text('${tarea.title?.substring(0, 2)}'),
            ),
            title: Text(tarea.title!),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    tarea.isCompleted == 1
                        ? FontAwesomeIcons.check
                        : FontAwesomeIcons.spinner,
                    color: tarea.isCompleted == 1
                        ? Colors.green
                        : Colors.yellowAccent),
                Text(
                  tarea.isCompleted == 0 ? 'Pendiente' : 'Completada',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            )),
      ),
    );
  }
}
