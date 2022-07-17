import 'package:flutter/material.dart';

class TextDatosLista {
  //estilo de de texto de la pantalla DatosLista
  static TextStyle style1 = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle style2 = const TextStyle(color: Colors.black);

//Tema configurado basado eb dark()
  static var styleTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: ThemeData.dark().colorScheme.secondary),
    primaryColorLight: Colors.black,
    scaffoldBackgroundColor: const Color(0xff16202b),
    textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.black)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        // backgroundColor: ThemeData.dark().colorScheme.secondary
        backgroundColor: Color(0xff6370ff)),
    appBarTheme: const AppBarTheme(
      // backgroundColor: ThemeData.dark().colorScheme.secondary,
      backgroundColor: Color(0xff6370ff),
    ),
  );
}
