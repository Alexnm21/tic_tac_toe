import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/bloc/game/game_bloc.dart';
import 'package:tic_tac_toe/game/view/game_view.dart';

import '../../core/bloc/cpu_game/cpu_game_bloc.dart';

class CpuGameView extends StatelessWidget {
  const CpuGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: BlocBuilder<CpuGameBloc, CpuGameState>(
        builder: (context, state) {
          return Column(
            children: [
              GameHeader(
                xTurn: state.xTurn,
                onReset: () => context.read<CpuGameBloc>().add(Reset()),
              ),
              GameBoard(
                board: state.board,
                onBoxTap: context.read<CpuGameBloc>().onBoxTap,
                winnerBoxes: state.winnerBoxes,
              ),
              GameScoreboard(scoreboard: state.scoreboard),
            ],
          );
        },
      ),
    );
  }
}
