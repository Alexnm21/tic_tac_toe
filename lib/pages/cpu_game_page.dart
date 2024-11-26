import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/bloc/cpu_game/cpu_game_bloc.dart';
import '../game/view/cpu_game_view.dart';

class CpuGamePage extends StatelessWidget {
  final String cpuValue;
  final CpuDifficulty difficulty;
  const CpuGamePage(
      {super.key, required this.cpuValue, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          CpuGameBloc(cpuValue: cpuValue, difficulty: difficulty),
      child: const CpuGameView(),
    ));
  }
}
