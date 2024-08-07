import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/sub_race.dart';
import '../../create_sub_race/create_sub_race_screen.dart';


class SubRaceTile extends StatelessWidget {
  const SubRaceTile({Key? key, required this.subRace}) : super(key: key);

  final SubRace subRace;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(vertical: 8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              subRace.name!,
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Raça Primária: ${subRace.parent_race!.name}',
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Traços da Raça: ${subRace.racial_traits?.map((trait) => trait.name).join(', ') ?? ''}',
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
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
            color: CustomColors.coconut,
          ),
        ),
      ),
    );
  }
}
