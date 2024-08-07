import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_item_category.dart';
import 'package:mestre_dos_magos/core/ui/components/patterned_buttom.dart';
import 'package:mestre_dos_magos/core/ui/components/title_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/models/item.dart';
import 'package:mestre_dos_magos/stores/create/create_item_store.dart';
import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import 'package:mobx/mobx.dart';

import '../../../stores/page_store.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/custom_field.dart';
import '../../../core/ui/components/custom_form_field.dart';
import '../../../stores/list/item_store.dart';

class CreateItemScreen extends StatefulWidget {
  const CreateItemScreen({Key? key, this.item}) : super(key: key);

  final Item? item;

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreateItemStore createItemStore;
  final itemStore = GetIt.I<ItemStore>();
  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.item != null;
    createItemStore = CreateItemStore(widget.item);

    //QUANDO SALVAR COM SUCESSO, VOLTA PARA A TELA ANTERIOR E RECARREGA OS DADOS
    when((_) => createItemStore.savedOrUpdatedOrDeleted, () {
      itemStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createItemStore.error, (error) {
      if (error != null) {
        print(error);
      }
    });
  }

  //Ao sair do widget
  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }

  void backToPreviousScreen() {
    pageStore.setBlockPagination(false);
    Navigator.of(context).pop();
  }

  //Marcação da Tela
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: editing ? 'Editar Item' : 'Cadastrar Item',
        onBackButtonPressed: backToPreviousScreen,
      ),
      body: BodyContainer(
        child: Row(
          children: [
            const NavigationPanelWeb(),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: CustomColors.coconut,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 15),
                              TitleTextForm(title: 'Nome do item'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createItemStore.name,
                                  onChanged: createItemStore.setName,
                                  error: createItemStore.nameError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Descrição do item'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createItemStore.description,
                                  onChanged: createItemStore.setDescription,
                                  error: createItemStore.descriptionError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Preço do Item'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createItemStore.price,
                                  onChanged: createItemStore.setPrice,
                                  error: createItemStore.priceError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Dano do Item'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createItemStore.damage,
                                  onChanged: createItemStore.setDamage,
                                  error: createItemStore.damageError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Efeito do Item'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createItemStore.effect,
                                  onChanged: createItemStore.setEffect,
                                  error: createItemStore.effectError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Categoria do Item'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                                child: Observer(
                                  builder: (context) => CustomField(
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => DialogItemCategory(
                                            selectedItemCategory: createItemStore.item_category
                                        ),
                                      );
                                      if (result != null) {
                                        createItemStore.setItemCategory(result);
                                      }
                                    },
                                    title: createItemStore.item_category?.name ?? "Selecione a Categoria",
                                    borderColor: createItemStore.itemCategoryError != null ? Colors.red.shade700 : Colors.grey.shade400,
                                    error: createItemStore.itemCategoryError,
                                    clearOnPressed: null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: PatternedButton(
                            color: Colors.red,
                            text: 'Excluir',
                            largura: screenSize.width * 0.3,
                            function: editing ? () async {
                              await createItemStore.deleteItem();
                            } : null,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createItemStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.coconut,
                                text: 'Salvar',
                                largura: screenSize.width * 0.6,
                                function: createItemStore.isFormValid ? () async {
                                  if (editing) {
                                    await createItemStore.editPressed();
                                  } else {
                                    await createItemStore.createPressed();
                                  }
                                } : null,
                              ),
                            ),
                          ),
                        ),
                      ],
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
