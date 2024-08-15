import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';

import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/information_field.dart';
import '../../../models/monster.dart';
import '../create_monster/create_monster_screen.dart';
import 'components/monster_image.dart';

class MonsterDetailsScreen extends StatelessWidget {
  const MonsterDetailsScreen({Key? key, required this.monster}) : super(key: key);

  final Monster monster;

  @override
  Widget build(BuildContext context) {
    void backToPreviousScreen() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: '${monster.name}',
        onBackButtonPressed: backToPreviousScreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateMonsterScreen(monster: monster),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: CustomColors.mystical_lilac,
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
                              MonsterImage(monster: monster),

                              const SizedBox(height: 24),
                              InformationField(
                                title: 'Descrição',
                                information: monster.description!,
                              ),

                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InformationField(
                                      title: 'HP',
                                      information: monster.hp!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Nível',
                                      information: monster.challenge_level!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'CA',
                                      information: monster.ca!.toString(),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),
                              InformationField(
                                title: 'Resistência e Perícias',
                                information: '${monster.endurance_tests!}, ${monster.expertise!}',
                              ),

                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InformationField(
                                      title: 'Força',
                                      information: monster.strength.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Constituição',
                                      information: monster.constitution!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Destreza',
                                      information: monster.dexterity!.toString(),
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
                                      title: 'Inteligência',
                                      information: monster.intelligence.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Sabedoria',
                                      information: monster.wisdom!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Carisma',
                                      information: monster.charisma!.toString(),
                                    ),
                                  ),
                                ],
                              ),

                              if (monster.skills != null && monster.skills!.isNotEmpty)...{
                                const SizedBox(height: 8),
                                InformationField(
                                  title: 'Habilidades',
                                  information: monster.skills!
                                      .map((skill) => '${skill.name!
                                      .toUpperCase()}: ${skill.description}')
                                      .join(';\n'),
                                ),
                              },

                              const SizedBox(height: 8),
                              InformationField(
                                title: 'Ações',
                                information: monster.actions!
                                    .map((action) => '${action.name!.toUpperCase()}: ${action.description}')
                                    .join(';\n'),
                              ),

                              if (monster.legendary_actions != null && monster.legendary_actions!.isNotEmpty)...{
                                const SizedBox(height: 8),
                                InformationField(
                                  title: 'Ações Lendárias',
                                  information: monster.legendary_actions!
                                    .map((legendaryAction) => '${legendaryAction.name!.toUpperCase()}: ${legendaryAction.description}')
                                    .join(';\n'),
                                ),
                              }
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
