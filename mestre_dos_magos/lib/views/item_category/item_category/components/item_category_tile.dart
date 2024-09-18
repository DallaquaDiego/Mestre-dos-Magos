import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/views/item_category/create_item_category/create_item_category_screen.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/item_category.dart';

class ItemCategoryTile extends StatelessWidget {
  const ItemCategoryTile({Key? key, required this.itemCategory}) : super(key: key);

  final ItemCategory itemCategory;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      //padding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(
        itemCategory.name!,
        style: TextStyle(
          color: CustomColors.just_regular_grey.withOpacity(0.8),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateItemCategoryScreen(itemCategory: itemCategory),
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
