import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';
import 'package:mestre_dos_magos/models/race.dart';

import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/information_field.dart';
import '../create_race/create_race_screen.dart';
import 'components/race_image.dart';

class RaceDetailsScreen extends StatelessWidget {
  const RaceDetailsScreen({Key? key, required this.race}) : super(key: key);

  final Race race;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    void backToPreviousScreen() {
      Navigator.of(context).pop();
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: '${race.name}',
        onBackButtonPressed: backToPreviousScreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateRaceScreen(race: race),
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
                              RaceImage(race: race),
                              const SizedBox(height: 24),
                              InformationField(
                                title: 'Descrição',
                                information: race.description!,
                              ),

                              const SizedBox(height: 8),
                              InformationField(
                                title: 'Traços Racias',
                                information: race.racial_trait!
                                    .map((trait) => '${trait.name!.toUpperCase()}: ${trait.description}')
                                    .join(';\n'),
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
