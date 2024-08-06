import 'package:mestre_dos_magos/core/ui/components/custom_drawer/componenets/page_section.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'componenets/custom_drawer_header.dart';
import 'componenets/navigation_alert_dialog.dart';
import '../../../../stores/page_store.dart';
import '../../theme/custom_colors.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final pageStore = GetIt.I.get<PageStore>();

  void navigateToPage({required int pageIndex, required BuildContext context}) {
    if (pageStore.blockPagination) {
      showDialog(
        context: context,
        builder: (context) => NavigationAlertDialog(
          onConfirmPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            pageStore.setPage(pageIndex);
            pageStore.setBlockPagination(false);
          },
        ),
      );
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
      pageStore.setPage(pageIndex);
      pageStore.setBlockPagination(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: CustomColors.papyrus,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: CustomColors.coconut,
          child: ListView(
            children: [
              const CustomDrawerHeader(
                name: 'Diego',
                office: 'Mestre dos Magos',
              ),
              PageSection(navigateToPage: navigateToPage),
            ],
          ),
        ),
      ),
    );
  }
}
