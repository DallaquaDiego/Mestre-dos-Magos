import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_racial_traits.dart';
import 'package:mestre_dos_magos/core/ui/components/patterned_buttom.dart';
import 'package:mestre_dos_magos/core/ui/components/title_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/models/item_category.dart';
import 'package:mestre_dos_magos/stores/list/item_category_store.dart';
import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import 'package:mobx/mobx.dart';
import '../../../stores/create/create_item_category_store.dart';
import '../../../stores/page_store.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/custom_form_field.dart';
import '../item_category/item_category_screen.dart';

class CreateItemCategoryScreen extends StatefulWidget {
  const CreateItemCategoryScreen({Key? key, this.itemCategory}) : super(key: key);

  final ItemCategory? itemCategory;

  @override
  State<CreateItemCategoryScreen> createState() => _CreateItemCategoryScreenState();
}

class _CreateItemCategoryScreenState extends State<CreateItemCategoryScreen> {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreateItemCategoryStore createItemCategoryStore;
  final itemCategoryStore = GetIt.I<ItemCategoryStore>();
  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.itemCategory != null;
    createItemCategoryStore = CreateItemCategoryStore(widget.itemCategory);

    //QUANDO SALVAR COM SUCESSO, VOLTA PARA A TELA ANTERIOR E RECARREGA OS DADOS
    when((_) => createItemCategoryStore.savedOrUpdatedOrDeleted, () {
      itemCategoryStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createItemCategoryStore.error, (error) {
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemCategoryScreen(),
      ),
    );
  }

  //Marcação da Tela
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: editing ? 'Editar Raça' : 'Cadastrar Raça',
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
                        color: CustomColors.grape_juice,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 15),
                              TitleTextForm(title: 'Nome da Categoria'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createItemCategoryStore.name,
                                  onChanged: createItemCategoryStore.setName,
                                  error: createItemCategoryStore.nameError,
                                  secret: false,
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
                    child: editing ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: PatternedButton(
                            color: CustomColors.mystical_lilac,
                            textColor: CustomColors.grape_juice,
                            text: 'Excluir',
                            largura: screenSize.width * 0.3,
                            function: editing ? () async {
                              await createItemCategoryStore.deleteItemCategory();
                            } : null,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createItemCategoryStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.grape_juice,
                                text: 'Salvar',
                                largura: screenSize.width * 0.65,
                                function: createItemCategoryStore.isFormValid ? () async {
                                  if (editing) {
                                    await createItemCategoryStore.editPressed();
                                  } else {
                                    await createItemCategoryStore.createPressed();
                                  }
                                } : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) : Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createItemCategoryStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.grape_juice,
                                text: 'Salvar',
                                largura: screenSize.width * 0.95,
                                function: createItemCategoryStore.isFormValid ? () async {
                                  if (editing) {
                                    await createItemCategoryStore.editPressed();
                                  } else {
                                    await createItemCategoryStore.createPressed();
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
