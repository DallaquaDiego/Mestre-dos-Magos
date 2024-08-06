import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'custom_colors.dart';

abstract class CustomTheme {
  static final ThemeData defaultTheme = ThemeData(
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: CustomColors.coconut,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CustomColors.coconut,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    scaffoldBackgroundColor: Colors.transparent,
    // Definindo as transições de página
    pageTransitionsTheme: PageTransitionsTheme(
      // Define os construtores de transições com base na plataforma em que o aplicativo está sendo executado
      builders: kIsWeb // Verifica se o aplicativo está sendo executado na web
          ? {
        // Se estiver na web, cria transições sem animações para cada plataforma suportada
        for (final platform in TargetPlatform.values) platform: const NoTransitionsBuilder(), // Define NoTransitionsBuilder() para cada plataforma
      }
      // Se não estiver na web
          : const {
        // Aqui definimos as transições para cada plataforma suportada
        //TargetPlatform.android: ZoomPageTransitionsBuilder(),
        //TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

// Classe que define construtores de transições sem animações
class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  // Método que constrói transições sem animações
  @override
  Widget buildTransitions<T>(
      PageRoute<T>? route,
      BuildContext? context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget? child,
      ) {
    // Retorna apenas o filho sem aplicar animações
    return child!;
  }
}
