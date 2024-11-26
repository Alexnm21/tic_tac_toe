part of '../view/game_view.dart';

class GameHeader extends StatelessWidget {
  final bool xTurn;
  final Function() onReset;
  const GameHeader({super.key, required this.xTurn, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Cross(size: 20, strokeWidth: 5),
        const SizedBox(width: 15),
        const Circle(size: 20, strokeWidth: 5),
        const Spacer(),
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.boxColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                xTurn
                    ? const Cross(
                        size: 15,
                        color: AppColors.buttonColor,
                      )
                    : const Circle(size: 15, color: AppColors.buttonColor),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'TURN',
                  style: TextStyle(color: AppColors.textLight),
                )
              ],
            )),
        const Spacer(),
        SizedBox(
            width: 50,
            height: 50,
            child: CustomButton(
              color: AppColors.buttonColor,
              shadowColor: AppColors.buttonShadowColor,
              onPressed: onReset,
              child: const Icon(Icons.refresh),
            ))
      ],
    );
  }
}
