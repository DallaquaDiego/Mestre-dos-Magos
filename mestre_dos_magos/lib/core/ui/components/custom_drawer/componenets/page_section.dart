import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'page_tile.dart';
import '../../../../../stores/page_store.dart';

class PageSection extends StatelessWidget {
  PageSection({Key? key, required this.navigateToPage}) : super(key: key);

  final pageStore = GetIt.I<PageStore>();
  final Function navigateToPage;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageTile(
            title: 'Mesa',
            iconData: Icons.table_bar,
            highlighted: pageStore.page == 0,
            onTap: () {
              navigateToPage(pageIndex: 0, context: context);
            },
          ),
          PageTile(
            title: 'Jogadores',
            iconData: Icons.person_search,
            highlighted: pageStore.page == 1,
            onTap: () {
              navigateToPage(pageIndex: 1, context: context);
            },
          ),
          PageTile(
            title: 'Monstros',
            iconData: Icons.adb,
            highlighted: pageStore.page == 2,
            onTap: () {
              navigateToPage(pageIndex: 2, context: context);
            },
          ),
          PageTile(
            title: 'Classes',
            iconData: Icons.shield_moon,
            highlighted: pageStore.page == 3,
            onTap: () {
              navigateToPage(pageIndex: 3, context: context);
            },
          ),
          PageTile(
            title: 'Raças',
            iconData: Icons.group,
            highlighted: pageStore.page == 4,
            onTap: () {
              navigateToPage(pageIndex: 4, context: context);
            },
          ),
          PageTile(
            title: 'Sub-Raças',
            iconData: Icons.groups,
            highlighted: pageStore.page == 5,
            onTap: () {
              navigateToPage(pageIndex: 5, context: context);
            },
          ),
          PageTile(
            title: 'Traços Raciais',
            iconData: Icons.fingerprint,
            highlighted: pageStore.page == 6,
            onTap: () {
              navigateToPage(pageIndex: 6, context: context);
            },
          ),
          PageTile(
            title: 'Magias',
            iconData: Icons.auto_awesome,
            highlighted: pageStore.page == 7,
            onTap: () {
              navigateToPage(pageIndex: 7, context: context);
            },
          ),
          PageTile(
            title: 'Itens',
            iconData: Icons.build,
            highlighted: pageStore.page == 8,
            onTap: () {
              navigateToPage(pageIndex: 8, context: context);
            },
          ),
          PageTile(
            title: 'Categoria dos Itens',
            iconData: Icons.category,
            highlighted: pageStore.page == 9,
            onTap: () {
              navigateToPage(pageIndex: 9, context: context);
            },
          ),
        ],
      ),
    );
  }
}
