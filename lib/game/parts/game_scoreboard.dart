part of '../view/game_view.dart';

class GameScoreboard extends StatelessWidget {
  final Scoreboard scoreboard;
  const GameScoreboard({super.key, required this.scoreboard});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ScoreboardContainer(
          title: 'X',
          score: scoreboard.xScore,
          color: AppColors.primary,
        ),
        const SizedBox(width: 15),
        _ScoreboardContainer(
          title: 'Ties',
          score: scoreboard.drawScore,
          color: AppColors.buttonColor,
        ),
        const SizedBox(width: 15),
        _ScoreboardContainer(
          title: 'O',
          score: scoreboard.oScore,
          color: AppColors.secondary,
        ),
      ],
    );
  }
}

class _ScoreboardContainer extends StatelessWidget {
  final String title;
  final int score;
  final Color color;
  const _ScoreboardContainer(
      {required this.title, required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            children: [
              Text(title,
                  style:
                      const TextStyle(fontSize: 20, color: AppColors.textDark)),
              Text(
                score.toString(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
