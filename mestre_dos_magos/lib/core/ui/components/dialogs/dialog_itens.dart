import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../models/item.dart';
import '../../../../stores/list/item_store.dart';
import '../../../global/custom_sizes.dart';
import '../../theme/custom_colors.dart';
import '../list_empty.dart';

class DialogItens extends StatelessWidget {
  DialogItens({Key? key, List<Item>? selectedItens})
      : _selectedItens = ObservableList<Item>.of(selectedItens ?? []),
        super(key: key);

  final itemStore = GetIt.I<ItemStore>();
  final ObservableList<Item> _selectedItens;
  final divider = const Divider(height: 0);

  void _toggleSelectedItem(Item newItem) {
    bool isAlreadySelected = _selectedItens.any((item) => item.id == newItem.id);
    if (isAlreadySelected) {
      _selectedItens.removeWhere((item) => item.id == newItem.id);
    } else {
      _selectedItens.add(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: CustomSizes.maxScreenWidth,
        ),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Selecione os Itens',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.grape_juice,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                          color: CustomColors.grape_juice,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
              divider,
              Observer(
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Container(
                      height: 63,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: CustomColors.grape_juice,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          onChanged: (value) => itemStore.runFilter(value),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: CustomColors.grape_juice,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Observer(
                builder: (context) {
                  if (itemStore.showProgress) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.grape_juice,
                        ),
                      ),
                    );
                  }
                  if (itemStore.listItem.isEmpty) {
                    return const Expanded(
                      child: ListEmpty(
                        texto: "Nenhum Item Encontrado!",
                      ),
                    );
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index < itemStore.listSearch.length) {
                                final item = itemStore.listSearch[index];
                                return InkWell(
                                  onTap: () {
                                    _toggleSelectedItem(item);
                                  },
                                  child: Observer(
                                    builder: (context) => Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedItens.any((selectedItem) => selectedItem.id == item.id)
                                            ? CustomColors.grape_juice.withAlpha(50)
                                            : null,
                                        border: itemStore.listItem.length - 1 == index
                                            ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                          ),
                                        )
                                            : null,
                                      ),
                                      child: Text(
                                        item.name!,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // Carregar próxima página ao chegar no final da lista
                              itemStore.loadNextPage();
                              return Center(
                                child: LinearProgressIndicator(
                                  color: CustomColors.grape_juice,
                                  backgroundColor: CustomColors.grape_juice.withAlpha(100),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => divider,
                            itemCount: itemStore.itemCount,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.grape_juice,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(_selectedItens);
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                color: CustomColors.alabaster,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
