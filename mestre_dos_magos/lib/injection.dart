import 'package:mestre_dos_magos/core/ui/components/custom_drawer/custom_drawer.dart';
import 'package:mestre_dos_magos/stores/list/class_store.dart';
import 'package:mestre_dos_magos/stores/filter_search_store.dart';
import 'package:mestre_dos_magos/stores/list/combat_type_store.dart';
import 'package:mestre_dos_magos/stores/list/item_category_store.dart';
import 'package:mestre_dos_magos/stores/list/item_store.dart';
import 'package:mestre_dos_magos/stores/list/monster_action_store.dart';
import 'package:mestre_dos_magos/stores/list/monster_legendary_action_store.dart';
import 'package:mestre_dos_magos/stores/list/monster_skill_store.dart';
import 'package:mestre_dos_magos/stores/list/monster_store.dart';
import 'package:mestre_dos_magos/stores/list/player_store.dart';
import 'package:mestre_dos_magos/stores/list/spell_category_store.dart';
import 'package:mestre_dos_magos/stores/list/sub_race_store.dart';
import 'package:mestre_dos_magos/stores/page_store.dart';
import 'package:mestre_dos_magos/stores/list/race_store.dart';
import 'package:mestre_dos_magos/stores/list/racial_trait_store.dart';
import 'package:mestre_dos_magos/stores/list/spell_store.dart';
import 'package:get_it/get_it.dart';

void configureDependencies() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(CustomDrawer());
  GetIt.I.registerSingleton(FilterSearchStore());
  GetIt.I.registerSingleton(ItemStore());
  GetIt.I.registerSingleton(ClassStore());
  GetIt.I.registerSingleton(SpellStore());
  GetIt.I.registerSingleton(RaceStore());
  GetIt.I.registerSingleton(SubRaceStore());
  GetIt.I.registerSingleton(RacialTraitStore());
  GetIt.I.registerSingleton(CombatTypeStore());
  GetIt.I.registerSingleton(ItemCategoryStore());
  GetIt.I.registerSingleton(SpellCategoryStore());
  GetIt.I.registerSingleton(PlayerStore());
  GetIt.I.registerSingleton(MonsterStore());
  GetIt.I.registerSingleton(MonsterSkillStore());
  GetIt.I.registerSingleton(MonsterActionStore());
  GetIt.I.registerSingleton(MonsterLegendaryActionStore());
}
