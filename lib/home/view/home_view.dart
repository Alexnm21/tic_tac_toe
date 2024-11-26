import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/bloc/cpu_game/cpu_game_bloc.dart';
import 'package:tic_tac_toe/core/theme/app_colors.dart';
import 'package:tic_tac_toe/core/widgets/circle.dart';
import 'package:tic_tac_toe/core/widgets/cross.dart';
import 'package:tic_tac_toe/core/widgets/custom_button.dart';
import 'package:tic_tac_toe/core/widgets/tic_tac_toe.dart';

import '../../pages/cpu_game_page.dart';
import '../../pages/game_page.dart';

part '../parts/cpu_game_dialog.dart';
part '../parts/difficulty_selector.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          const TicTacToe(),
          const SizedBox(height: 50),
          CustomButton(
            color: AppColors.secondary,
            shadowColor: AppColors.secondaryShadow,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const CpuGameDialog();
                  });
            },
            child: const Text(
              'PLAY SOLO',
              style: TextStyle(
                  color: AppColors.textDark, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            color: AppColors.primary,
            shadowColor: AppColors.primaryShadow,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GamePage()));
            },
            child: const Text(
              'PLAY WITH FRIEND',
              style: TextStyle(
                  color: AppColors.textDark, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
