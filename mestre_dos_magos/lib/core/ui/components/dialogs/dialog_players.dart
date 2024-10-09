import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../models/player.dart';
import '../../../../stores/list/player_store.dart';
import '../../../global/custom_sizes.dart';
import '../../theme/custom_colors.dart';
import '../empty_result.dart';

class PlayersDialog extends StatelessWidget {
  PlayersDialog({Key? key, List<Player>? selectedPlayers})
      : _selectedPlayers = ObservableList<Player>.of(selectedPlayers ?? []),
        super(key: key);

  final playerStore = GetIt.I<PlayerStore>();
  final ObservableList<Player> _selectedPlayers;
  final divider = const Divider(height: 0);

  void _toggleSelectedPlayer(BuildContext context, Player newPlayer) {
    bool isAlreadySelected = _selectedPlayers.any((player) => player.id == newPlayer.id);
    if (isAlreadySelected) {
      _selectedPlayers.removeWhere((player) => player.id == newPlayer.id);
    } else {
      if (_selectedPlayers.length < 4) {
        _selectedPlayers.add(newPlayer);
      }
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
                        'Selecione no Máximo 4 Jogadores',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.dragon_blood,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                          color: CustomColors.dragon_blood,
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
                          color: CustomColors.dragon_blood,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          onChanged: (value) => playerStore.runFilter(value),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: CustomColors.dragon_blood,
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
                  if (playerStore.showProgress) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.dragon_blood,
                        ),
                      ),
                    );
                  }
                  if (playerStore.listPlayer.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhum Jogador Encontrado!',
                          reload: playerStore.refreshData,
                        ),
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
                              if (index < playerStore.listSearch.length) {
                                final player = playerStore.listSearch[index];
                                return InkWell(
                                  onTap: () {
                                    _toggleSelectedPlayer(context, player);
                                  },
                                  child: Observer(
                                    builder: (context) => Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedPlayers.any((selectedPlayer) => selectedPlayer.id == player.id)
                                            ? CustomColors.dragon_blood.withAlpha(50)
                                            : null,
                                        border: playerStore.listPlayer.length - 1 == index
                                            ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                          ),
                                        )
                                            : null,
                                      ),
                                      child: Text(
                                        player.name!,
                                        style: const TextStyle(
                                          color: CustomColors.dirty_brown,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // Carregar próxima página ao chegar no final da lista
                              playerStore.loadNextPage();
                              return Center(
                                child: LinearProgressIndicator(
                                  color: CustomColors.dragon_blood,
                                  backgroundColor: CustomColors.dragon_blood.withAlpha(100),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => divider,
                            itemCount: playerStore.itemCount,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.dragon_blood,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(_selectedPlayers);
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                color: CustomColors.white_mist,
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
