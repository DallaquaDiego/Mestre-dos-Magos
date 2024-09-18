import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';

import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/information_field.dart';
import '../../../models/spell.dart';
import '../create_spell/create_spell_screen.dart';

class SpellDetailsScreen extends StatelessWidget {
  const SpellDetailsScreen({Key? key, required this.spell}) : super(key: key);

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    void backToPreviousScreen() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: '${spell.name}',
        onBackButtonPressed: backToPreviousScreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateSpellScreen(spell: spell),
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
                              InformationField(
                                title: 'Descrição',
                                information: spell.description!,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InformationField(
                                      title: 'Nível',
                                      information: spell.isTrick! ? 'Truque' : spell.spell_level.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Categoria',
                                      information: spell.spell_category!.name!,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (spell.effect_on_ally != null && spell.effect_on_ally != '')...{
                                InformationField(
                                  title: 'Efeito nos Aliados',
                                  information: spell.effect_on_ally!,
                                ),
                                const SizedBox(height: 8),
                              },
                              if (spell.effect_on_foe != null && spell.effect_on_foe != '')...{
                                InformationField(
                                  title: 'Efeito nos Inimigos',
                                  information: spell.effect_on_foe!,
                                ),
                                const SizedBox(height: 8),
                              },

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (spell.damage != null && spell.damage != '')...{
                                    Expanded(
                                      child: InformationField(
                                        title: 'Dano',
                                        information: spell.damage!,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  },
                                  Expanded(
                                    child: InformationField(
                                      title: spell.isTrick! ? 'Duração do Truque' : 'Duração da Magia',
                                      information: spell.duration!,
                                    ),
                                  ),
                                ],
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
