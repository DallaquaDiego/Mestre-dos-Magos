import 'package:device_preview/device_preview.dart';
import 'package:mestre_dos_magos/back4app.dart';
import 'package:mestre_dos_magos/views/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'core/ui/theme/custom_colors.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Back4App.initParse();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      locale: DevicePreview.locale(context),
      builder: (context, widget) {
        final responsive = ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          minWidth: 400,
          defaultName: MOBILE,
          defaultScale: true,
          background: Container(color: CustomColors.papyrus),
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.resize(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            //const ResponsiveBreakpoint.autoScale(2160, name: '4k'),
          ],
        );
        return DevicePreview.appBuilder(context, responsive); // return com o device_preview
      },

      title: 'Mestre dos Magos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BaseScreen(),
    );
  }
}

