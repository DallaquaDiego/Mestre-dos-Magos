import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../stores/list/class_store.dart';
import '../../../../stores/filter_search_store.dart';

class FilterVisibleClass extends StatefulWidget {
  FilterVisibleClass({super.key, required this.filterStore});

  final FilterSearchStore filterStore;

  @override
  State<FilterVisibleClass> createState() => _FilterVisibleClassState();
}

class _FilterVisibleClassState extends State<FilterVisibleClass> {
  //recebe uma copia do filtro que esta na HomeStore
  final FilterSearchStore filterStoreGet = GetIt.I<FilterSearchStore>();

  final ClassStore classStore = GetIt.I<ClassStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pesquise pelo Nome da Classe',
              style: TextStyle(
                color: CustomColors.grape_juice,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Observer(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  child: TextFormField(
                    cursorColor: CustomColors.grape_juice,
                    keyboardType: TextInputType.text,
                    initialValue: widget.filterStore.search,
                    onChanged: widget.filterStore.setSearch,
                    obscureText: false,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomColors.grape_juice,
                            width: 1,
                          )),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: CustomColors.grape_juice,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusColor: CustomColors.grape_juice,
                      errorText: null,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.text_fields_rounded,
                          color: CustomColors.grape_juice,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //BOTAO LIMPAR
            Observer(builder: (_) {
              if (widget.filterStore.isFilterCount) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        backgroundColor: CustomColors.mystical_lilac,
                      ),
                      onPressed: () async {
                        filterStoreGet.clearFilters();
                        widget.filterStore.clearFilters();
                        classStore.setFilter(widget.filterStore);
                        filterStoreGet.setVisibleSearchFalse();

                      },
                      child: Text(
                        'Limpar filtros',
                        style: TextStyle(
                          //fontFamily: ,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: CustomColors.grape_juice,

                          shadows: [
                            Shadow(
                              color: Colors.grey.withOpacity(0.5), // Cor da sombra
                              offset: const Offset(0, 2), // Deslocamento da sombra (x, y)
                              blurRadius: 4, // O quão embaçada é a sombra
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),

            const SizedBox(height: 5),

            //BOTAO
            Observer(builder: (_) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: CustomColors.grape_juice,
                    ),
                    onPressed: widget.filterStore.isFormValid ? () async {
                      filterStoreGet.setVisibleSearchFalse();
                      classStore.setFilter(widget.filterStore);
                    } : null,
                    child: Text(
                      'Aplicar filtros',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: CustomColors.alabaster,
                        shadows: [
                          Shadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      );
    });
  }
}
