// ignore_for_file: use_build_context_synchronously

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:lista_tareas/models/tarea_model.dart';
import 'package:lista_tareas/provider/provider.dart';
import 'package:lista_tareas/provider/form_provider.dart';
import 'package:lista_tareas/widget/widget.dart';

//Vista del formulario para agregar o editar una tarea, en esta parte se manda a llamar el provider del formulario
class FormularioScreen extends StatelessWidget {
  const FormularioScreen(
      {Key? key,
      required this.tareaProvider,
      required this.tarea,
      required this.funcion})
      : super(key: key);
  final TareasProvider tareaProvider;
  final Tarea tarea;
  final String funcion;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FromProvider(tarea),
      child: _Scaffold(
        tareaProvider: tareaProvider,
        funcion: funcion,
      ),
    );
  }
}

//Scaffold principal de la vusta se recibe aqui la variable si se desea editar o actualizar,
//se mandar a llamar diferentes funciones de tareas_provider 
class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
    required this.tareaProvider,
    required this.funcion,
  }) : super(key: key);
  final TareasProvider tareaProvider;
  final String funcion;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FromProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Center(child: Text(funcion == 'Agregar' ? 'Agregar' : 'Editar')),
      ),
      body: tareaProvider.cargar
          ? const _From()
          : const CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        onPressed: tareaProvider.cargar
            ? () async {
                if (!provider.isValidForm()) return;
                if (funcion == 'Agregar') {
                  await tareaProvider.agregarTarea(provider.tarea);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Se agrego la tarea')));
                } else {
                  await tareaProvider.editarTarea(provider.tarea);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Se Edito la tarea')));
                }
              }
            : null,
        child: tareaProvider.cargar
            ? const Icon(Icons.save)
            : const CircularProgressIndicator(),
      ),
    );
  }
}

//contiene todos los TextFormField del formulario con sus respectivas validaciones
class _From extends StatelessWidget {
  const _From({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FromProvider>(context);

    return Form(
        key: provider.formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              const Icon(Icons.app_registration, size: 100),
              CustomImput(
                texfiel: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  initialValue: provider.tarea.title,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.person),
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      label: Text('Titulo'),
                      hintText: 'Titulo'),
                  onChanged: (valor) {
                    provider.tarea.title = valor;
                  },
                  validator: (valor) {
                    if (valor == null || valor.isEmpty || valor.length < 4) {
                      return 'El Titulo es requerido o mayor a 4 letras';
                    }
                    return null;
                  },
                ),
              ),
              Column(
                children: [
                  const Text(' Completada o no completada'),
                  CupertinoSwitch(
                      value: provider.tarea.isCompleted == 0 ? false : true,
                      onChanged: (valor) {
                        provider.terminar = valor;
                      }),
                ],
              ),
              CustomImput(
                texfiel: DateTimePicker(
                  style: const TextStyle(color: Colors.black),
                  dateLabelText: 'Fecha de vencimiento',
                  dateHintText: 'Fecha de vencimiento',
                  initialValue: provider.tarea.dueDate,
                  initialDate: provider.tarea.dueDate != null
                      ? DateTime.parse(provider.tarea.dueDate)
                      : DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  onChanged: (valor) {
                    provider.tarea.dueDate = valor;
                  },
                ),
              ),
              CustomImput(
                texfiel: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  initialValue: provider.tarea.comments,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),

                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.comment),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    label: Text('Comentarios'),
                    // hintText: 'Comentarios',
                  ),
                  onChanged: (valor) {
                    provider.tarea.comments = valor;
                  },
                ),
              ),
              CustomImput(
                texfiel: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  initialValue: provider.tarea.description,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.description),
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      label: Text('Descripción'),
                      hintText: 'Descripción'),
                  onChanged: (valor) {
                    provider.tarea.description = valor;
                  },
                ),
              ),
              CustomImput(
                texfiel: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  initialValue: provider.tarea.tags,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.tag),
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      label: Text('Tags'),
                      hintText: 'tags'),
                  onChanged: (valor) {
                    provider.tarea.tags = valor;
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
