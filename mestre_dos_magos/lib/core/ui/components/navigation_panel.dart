import 'package:mestre_dos_magos/core/ui/components/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NavigationPanelWeb extends StatelessWidget {
  const NavigationPanelWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: const [
        Condition.largerThan(name: MOBILE),
      ],
      child: CustomDrawer(),
    );
  }
}
