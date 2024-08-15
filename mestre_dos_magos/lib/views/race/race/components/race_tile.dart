import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/models/race.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../create_race/create_race_screen.dart';
import '../../race_details/race_details_screen.dart';


class RaceTile extends StatelessWidget {
  const RaceTile({Key? key, required this.race}) : super(key: key);

  final Race race;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(vertical: 8),
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RaceDetailsScreen(race: race),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                race.name!,
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Traços da Raça: ${race.racial_trait?.map((trait) => trait.name).join(', ') ?? ''}',
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateRaceScreen(race: race),
              )
            );
          },
          icon: const Icon(
            Icons.edit,
            color: CustomColors.amethyst,
          ),
        ),
      ),
    );
  }
}
