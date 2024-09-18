import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';

import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/information_field.dart';
import '../../../models/player.dart';
import '../create_player/create_player_screen.dart';

class PlayerDetailsScreen extends StatelessWidget {
  const PlayerDetailsScreen({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    void backToPreviousScreen() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: '${player.name}',
        onBackButtonPressed: backToPreviousScreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreatePlayerScreen(player: player),
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
                                title: 'Classe',
                                information: player.classe!.name!,
                              ),

                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InformationField(
                                      title: 'HP',
                                      information: player.hp.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Idade',
                                      information: player.age.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Nível',
                                      information: player.level!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'CA',
                                      information: player.ca!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'CD',
                                      information: player.cd!.toString(),
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
                                      title: 'Força',
                                      information: player.strength.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Constituição',
                                      information: player.constitution!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Destreza',
                                      information: player.dexterity!.toString(),
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
                                      information: player.intelligence.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Sabedoria',
                                      information: player.wisdom!.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Carisma',
                                      information: player.charisma!.toString(),
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
                                      title: 'Raça',
                                      information: player.race!.name!,
                                    ),
                                  ),
                                  if(player.sub_race != null)...{
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InformationField(
                                        title: 'Sub-Raça',
                                        information: player.sub_race!.name!,
                                      ),
                                    ),
                                  }
                                ],
                              ),

                              const SizedBox(height: 8),
                              if (player.spells != null)...{
                                InformationField(
                                  title: 'Magias',
                                  information: player.spells!.map((spell) => spell.name).join(', '),
                                ),
                              },

                              const SizedBox(height: 8),
                              if (player.itens != null)...{
                                InformationField(
                                  title: 'Itens',
                                  information: player.itens!.map((item) => item.name).join(', '),
                                ),
                              },

                              const SizedBox(height: 8),
                              if (player.sub_race != null && player.sub_race?.racial_trait != null)...{
                                InformationField(
                                  title: 'Traços Raciais',
                                  information: '${player.race!.racial_trait!
                                      .map((trait) => trait.name)
                                      .join(';\n')}, ${player.sub_race!.racial_trait!
                                        .map((trait) => trait.name)
                                        .join(', ')}',
                                ),
                              } else...{
                                InformationField(
                                  title: 'Traços Raciais',
                                  information: player.race!.racial_trait!
                                      .map((trait) => trait.name)
                                      .join(', ')
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
