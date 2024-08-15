import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/sub_race.dart';
import '../../create_sub_race/create_sub_race_screen.dart';
import '../../sub_race_details/sub_race_details_screen.dart';


class SubRaceTile extends StatelessWidget {
  const SubRaceTile({Key? key, required this.subRace}) : super(key: key);

  final SubRace subRace;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(vertical: 8),
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubRaceDetailsScreen(subRace: subRace),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                subRace.name!,
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Raça Primária: ${subRace.parent_race!.name}',
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'Traços da Raça: ${subRace.racial_trait?.map((trait) => trait.name).join(', ') ?? ''}',
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
                builder: (context) => CreateSubRaceScreen(subRace: subRace),
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
