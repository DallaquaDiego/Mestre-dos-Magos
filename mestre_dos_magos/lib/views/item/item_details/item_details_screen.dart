import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/core/ui/theme/custom_colors.dart';
import 'package:mestre_dos_magos/models/item.dart';

import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/information_field.dart';
import '../create_item/create_item_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    void backToPreviousScreen() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: '${item.name}',
        onBackButtonPressed: backToPreviousScreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateItemScreen(item: item),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: CustomColors.white_mist,
      body: BodyContainer(
        child: Row(
          children: [
            const NavigationPanelWeb(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              InformationField(
                                title: 'Descrição',
                                information: item.description!,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InformationField(
                                      title: 'Preço',
                                      information: '${item.price.toString()} po',
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InformationField(
                                      title: 'Categoria',
                                      information: item.item_category!.name!,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (item.damage != null && item.damage != '')...{
                                InformationField(
                                  title: 'Dano',
                                  information: item.damage!,
                                ),
                                const SizedBox(height: 8),
                              },
                              if (item.effect != null && item.effect != '')...{
                                InformationField(
                                  title: 'Efeito do Item',
                                  information: item.effect!,
                                ),
                                const SizedBox(height: 8),
                              },
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
