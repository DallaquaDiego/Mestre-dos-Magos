import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';
import 'package:mestre_dos_magos/models/class.dart';

import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/information_field.dart';
import '../create_class/create_class_screen.dart';
import 'components/class_image.dart';

class ClassDetailsScreen extends StatelessWidget {
  const ClassDetailsScreen({Key? key, required this.classe}) : super(key: key);

  final Class classe;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    void backToPreviousScreen() {
      Navigator.of(context).pop();
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: '${classe.name}',
        onBackButtonPressed: backToPreviousScreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateClassScreen(classe: classe),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: CustomColors.white_mist,
      body: BodyContainer(
        child: Row(
          children: [
            const NavigationPanelWeb(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              ClassImage(classe: classe),
                              const SizedBox(height: 24),
                              InformationField(
                                title: 'Descrição',
                                information: classe.description!,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InformationField(
                                      title: 'HP por Nível',
                                      information: classe.hp_per_level!,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Combate',
                                      information: classe.combat_type!.name!,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InformationField(
                                      title: 'Atributos Primários',
                                      information: classe.primary_attributes!,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Proficiências em Resistência',
                                      information: classe.resistance_proficiency!,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),
                              InformationField(
                                title: 'Proficiências em Armas e Armaduras',
                                information: classe.weapon_and_armor_proficiency!,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
