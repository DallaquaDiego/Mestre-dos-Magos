import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/views/item/create_item/create_item_screen.dart';

import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/item.dart';
import '../../item_details/item_details_screen.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(vertical: 8),
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ItemDetailsScreen(item: item),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.name!,
                style: TextStyle(
                  color: CustomColors.just_regular_grey.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Categoria: ${item.item_category!.name}',
                style: TextStyle(
                  color: CustomColors.just_regular_grey.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'Preço: ${item.price} po',
                style: TextStyle(
                  color: CustomColors.just_regular_grey.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                ),
              ),
              if(item.effect != null && item.effect != '')...{
                const SizedBox(height: 1),
                Text(
                  'Efeitos: ${item.effect!}',
                  style: TextStyle(
                    color: CustomColors.just_regular_grey.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              },
              if(item.damage != null && item.damage != '')...{
                const SizedBox(height: 1),
                Text(
                  'Dano: ${item.damage!}',
                  style: TextStyle(
                    color: CustomColors.just_regular_grey.withOpacity(0.8),
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
                builder: (context) => CreateItemScreen(item: item),
              )
            );
          },
          icon: Icon(
            Icons.edit,
            color: CustomColors.just_regular_grey.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
