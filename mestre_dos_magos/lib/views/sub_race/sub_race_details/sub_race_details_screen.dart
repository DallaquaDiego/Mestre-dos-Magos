import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';

import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/information_field.dart';
import '../../../models/sub_race.dart';
import '../create_sub_race/create_sub_race_screen.dart';

class SubRaceDetailsScreen extends StatelessWidget {
  const SubRaceDetailsScreen({Key? key, required this.subRace}) : super(key: key);

  final SubRace subRace;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    void backToPreviousScreen() {
      Navigator.of(context).pop();
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: '${subRace.name}',
        onBackButtonPressed: backToPreviousScreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateSubRaceScreen(subRace: subRace),
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
                                information: subRace.description!,
                              ),
                              
                              const SizedBox(height: 8),
                              InformationField(
                                title: 'Traços Raciais',

                                information: subRace.racial_trait!
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
