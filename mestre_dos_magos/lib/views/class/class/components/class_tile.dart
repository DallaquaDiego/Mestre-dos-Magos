import 'package:mestre_dos_magos/views/class/create_class/create_class_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/class.dart';

class ClassTile extends StatelessWidget {
  const ClassTile({Key? key, required this.classe}) : super(key: key);

  final Class classe;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(vertical: 8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              classe.name!,
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'Atributos Primários: ${classe.primary_attributes}',
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Combate: ${classe.combat_type?.name}',
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'Dado de Vida: ${classe.hp_per_level}',
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
                builder: (context) => CreateClassScreen(classe: classe),
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
