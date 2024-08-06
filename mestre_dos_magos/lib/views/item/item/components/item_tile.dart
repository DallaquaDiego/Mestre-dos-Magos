import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/views/item/create_item/create_item_screen.dart';

import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/item.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(vertical: 8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              item.name!,
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'Categoria: ${item.itemCategory!.name}',
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Preço: ${item.price} po',
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              item.effect != null && item.effect != '' ? 'Efeitos: ${item.effect!}' : 'Efeitos: Nenhum',
              style: const TextStyle(
                color: CustomColors.coconut,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              item.damage != null && item.damage != ''? 'Dano: ${item.damage!}' : 'Dano: Nenhum',
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
                builder: (context) => CreateItemScreen(item: item),
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
