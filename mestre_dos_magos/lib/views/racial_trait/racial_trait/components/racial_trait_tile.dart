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
        style: TextStyle(
          color: CustomColors.just_regular_grey.withOpacity(0.8),
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
        icon: Icon(
          Icons.edit,
          color: CustomColors.just_regular_grey.withOpacity(0.8),
        ),
      ),
    );
  }
}
