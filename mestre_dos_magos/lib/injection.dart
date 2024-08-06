import 'package:mestre_dos_magos/core/ui/components/custom_drawer/custom_drawer.dart';
import 'package:mestre_dos_magos/stores/class_store.dart';
import 'package:mestre_dos_magos/stores/filter_search_store.dart';
import 'package:mestre_dos_magos/stores/item_store.dart';
import 'package:mestre_dos_magos/stores/page_store.dart';
import 'package:get_it/get_it.dart';

void configureDependencies() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(CustomDrawer());
  GetIt.I.registerSingleton(FilterSearchStore());
  GetIt.I.registerSingleton(ItemStore());
  GetIt.I.registerSingleton(ClassStore());
}
