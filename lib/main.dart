import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lista_tareas/provider/provider.dart';
import 'package:lista_tareas/screen/screen.dart';
import 'package:lista_tareas/style/style.dart';

void main() => runApp(
  //se inicaliza el provider del tema para poder cambiarlo
  ChangeNotifierProvider(
    create: (_) => ThemeProvider(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista Tareas',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
        },
        theme: !themeProvider.tema
            ? TextDatosLista.styleTheme
            : ThemeData.light());
  }
}
