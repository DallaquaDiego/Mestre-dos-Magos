import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';
import 'package:mestre_dos_magos/models/monster.dart';

import '../../../../stores/create/create_monster_store.dart';

class MonsterDamageDialog extends StatefulWidget {
  const MonsterDamageDialog({Key? key, required this.heal, this.monster,}) : super(key: key);

  final bool heal;
  final Monster? monster;

  @override
  _MonsterDamageDialogState createState() => _MonsterDamageDialogState();
}

class _MonsterDamageDialogState extends State<MonsterDamageDialog> {
  final TextEditingController _controller = TextEditingController();
  late final CreateMonsterStore createMonsterStore;

  @override
  void initState() {
    super.initState();
    createMonsterStore = CreateMonsterStore(widget.monster);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.heal ? 'Cura' : 'Dano',
        style: const TextStyle(color: CustomColors.grape_juice),
      ),
      backgroundColor: CustomColors.mystical_lilac,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: CustomColors.grape_juice),
        decoration: InputDecoration(
          hintText: widget.heal ? 'Cura: ' : 'Dano: ',
          fillColor: CustomColors.amethyst.withOpacity(0.1),
          filled: true,
          hintStyle: const TextStyle(color: CustomColors.grape_juice, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: CustomColors.alabaster,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.alabaster,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: CustomColors.grape_juice),
                ),
              ),
              ElevatedButton(
                onPressed: () => _adjustHp(context, createMonsterStore),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.heal ? CustomColors.amethyst : CustomColors.grape_juice,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(color: CustomColors.alabaster),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _adjustHp(BuildContext context, CreateMonsterStore createMonsterStore) {
    final int? value = int.tryParse(_controller.text);

    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insira um valor válido.'),
        ),
      );
      return;
    }

    if (widget.monster != null) {
      if (widget.heal) {
        createMonsterStore.setCurrentHp(
          (widget.monster!.current_hp! + value).clamp(0, widget.monster!.hp!).toString(),
        );
      } else {
        createMonsterStore.setCurrentHp(
          (widget.monster!.current_hp! - value).clamp(0, widget.monster!.hp!).toString(),
        );
      }

      createMonsterStore.editMonster();
    }
    Navigator.of(context).pop();
  }
}
