// ignore_for_file: non_constant_identifier_names

import 'package:mestre_dos_magos/views/class/class/class_screen.dart';
import 'package:mestre_dos_magos/views/item/item/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/views/item_category/item_category/item_category_screen.dart';
import 'package:mestre_dos_magos/views/monster/monster/monster_screen.dart';
import 'package:mestre_dos_magos/views/player/player/player_screen.dart';
import 'package:mestre_dos_magos/views/race/race/race_screen.dart';
import 'package:mestre_dos_magos/views/racial_trait/racial_trait/racial_trait_screen.dart';
import 'package:mestre_dos_magos/views/spell/spell/spell_screen.dart';
import 'package:mestre_dos_magos/views/table/table/table_screen.dart';
import '../../core/ui/components/body_container.dart';
import '../../core/ui/components/custom_drawer/custom_drawer.dart';
import '../../core/ui/components/navigation_panel.dart';
import '../../core/ui/theme/custom_colors.dart';
import 'package:mobx/mobx.dart';
import '../../stores/page_store.dart';
import '../sub_race/sub_race/sub_race_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  final PageStore pageStore = GetIt.I<PageStore>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(false);
    reaction((_) => pageStore.page, (page) {
      pageController.jumpToPage(page);
    });
  }

  Widget TestPage({required String title}) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.white_mist,
        title: Text(
          title,
          style: const TextStyle(
            color: CustomColors.dragon_blood,
          ),
        ),
        iconTheme: const IconThemeData().copyWith(
          color: CustomColors.dragon_blood,
        ),
      ),
      extendBodyBehindAppBar: true,
      drawer: CustomDrawer(),
      backgroundColor: CustomColors.white_mist,
      body: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
          body: BodyContainer(
            child: Row(
              children: [
                const NavigationPanelWeb(),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      TableScreen(),
                      PlayerScreen(),
                      MonsterScreen(),
                      ClassScreen(),
                      RaceScreen(),
                      SubRaceScreen(),
                      RacialTraitScreen(),
                      SpellScreen(),
                      ItemScreen(),
                      ItemCategoryScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
