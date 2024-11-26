part of '../view/game_view.dart';

class GameBoard extends StatelessWidget {
  final Board board;
  final List<Box>? winnerBoxes;
  final Function({required int row, required int col}) onBoxTap;
  const GameBoard(
      {super.key,
      required this.board,
      required this.onBoxTap,
      this.winnerBoxes});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          int row = index ~/ 3;
          int col = index % 3;
          Color? backgroundColor;
          Color? shadowColor;

          if (winnerBoxes?.isNotEmpty ?? false) {
            for (Box box in winnerBoxes!) {
              if (box.row == row && box.col == col) {
                if (board.getBox(row: row, col: col).value == 'X') {
                  backgroundColor = AppColors.primary;
                  shadowColor = AppColors.primaryShadow;
                } else {
                  backgroundColor = AppColors.secondary;
                  shadowColor = AppColors.secondaryShadow;
                }
              }
            }
          }
          return _GameBox(
              value: board.getBox(row: row, col: col).value,
              onBoxTap: () => onBoxTap(row: row, col: col),
              backgroundColor: backgroundColor,
              shadowColor: shadowColor);
        },
      ),
    );
  }
}

class _GameBox extends StatelessWidget {
  final String value;
  final Function() onBoxTap;
  final Color? backgroundColor;
  final Color? shadowColor;
  const _GameBox(
      {required this.value,
      required this.onBoxTap,
      this.backgroundColor,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    Color containerColor = backgroundColor ?? AppColors.boxColor;
    Color valueColor = backgroundColor != null
        ? AppColors.boxColor
        : value == 'X'
            ? AppColors.primary
            : AppColors.secondary;
    return GestureDetector(
      onTap: onBoxTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            bottom: BorderSide(
              color: shadowColor ?? AppColors.boxShadowColor,
              width: 6,
            ),
          ),
        ),
        child: value.isNotEmpty
            ? Center(
                child: value == 'X'
                    ? Cross(size: 40, strokeWidth: 5, color: valueColor)
                    : Circle(size: 40, strokeWidth: 5, color: valueColor),
              )
            : null,
      ),
    );
  }
}
