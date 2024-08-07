import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/racial_trait.dart';
import '../../create_racial_trait/create_racial_trait_screen.dart';


class RacialTraitTile extends StatelessWidget {
  const RacialTraitTile({Key? key, required this.racialTrait}) : super(key: key);

  final RacialTrait racialTrait;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      //padding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(
        racialTrait.name!,
        style: const TextStyle(
          color: CustomColors.coconut,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateRacialTraitScreen(racialTrait: racialTrait),
              )
          );
        },
        icon: const Icon(
          Icons.edit,
          color: CustomColors.coconut,
        ),
      ),
    );
  }
}
