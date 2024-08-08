import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/spell.dart';
import '../../create_spell/create_spell_screen.dart';
import '../../spell_details/spell_details_screen.dart';

class SpellTile extends StatelessWidget {
  const SpellTile({Key? key, required this.spell}) : super(key: key);

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(vertical: 8),
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SpellDetailsScreen(spell: spell),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                spell.name!,
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Categoria: ${spell.spell_category!.name}',
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                spell.isTrick! || spell.spell_level == 0 ? 'Nível da Magia: Truque' : 'Nível da Magia: ${spell.spell_level}',
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w400,
                ),
              ),

              if(spell.damage != null && spell.damage != '')...{
                const SizedBox(height: 1),
                Text(
                  'Dano: ${spell.damage!}',
                  style: const TextStyle(
                    color: CustomColors.amethyst,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              },
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateSpellScreen(spell: spell),
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
