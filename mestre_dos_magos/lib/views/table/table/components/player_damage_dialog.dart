import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';
import 'package:mestre_dos_magos/models/player.dart';
import '../../../../stores/create/create_player_store.dart';

class PlayerDamageDialog extends StatefulWidget {
  const PlayerDamageDialog({
    Key? key,
    required this.heal,
    this.player,
    required this.onUpdate,
  }) : super(key: key);

  final bool heal;
  final Player? player;
  final VoidCallback onUpdate;

  @override
  _PlayerDamageDialogState createState() => _PlayerDamageDialogState();
}

class _PlayerDamageDialogState extends State<PlayerDamageDialog> {
  final TextEditingController _controller = TextEditingController();
  late final CreatePlayerStore createPlayerStore;

  @override
  void initState() {
    super.initState();
    createPlayerStore = CreatePlayerStore(widget.player);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: CustomColors.white_mist,
      title: Text(
        widget.heal ? 'Cura' : 'Dano',
        style: const TextStyle(color: CustomColors.dragon_blood),
      ),
      content: SingleChildScrollView(
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: CustomColors.dragon_blood),
          decoration: InputDecoration(
            hintText: widget.heal ? 'Valor da cura: ' : 'Valor do dano: ',
            fillColor: CustomColors.ancient_gold.withOpacity(0.1),
            filled: true,
            hintStyle: const TextStyle(color: CustomColors.dragon_blood, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: CustomColors.white_mist,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.white_mist,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: CustomColors.dragon_blood),
                ),
              ),
              ElevatedButton(
                onPressed: () => _adjustHp(context, createPlayerStore),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.heal ? CustomColors.ancient_gold : CustomColors.dragon_blood,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(color: CustomColors.white_mist),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _adjustHp(BuildContext context, CreatePlayerStore createPlayerStore) {
    final int? value = int.tryParse(_controller.text);

    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insira um valor válido.'),
        ),
      );
      return;
    }

    if (widget.player != null) {
      if (widget.heal) {
        createPlayerStore.setCurrentHp(
          (widget.player!.current_hp! + value).clamp(0, widget.player!.hp!).toString(),
        );
      } else {
        createPlayerStore.setCurrentHp(
          (widget.player!.current_hp! - value).clamp(0, widget.player!.hp!).toString(),
        );
      }

      createPlayerStore.editPlayer();
    }
    Navigator.of(context).pop();
    widget.onUpdate();
  }
}
