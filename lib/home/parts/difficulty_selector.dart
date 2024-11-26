part of '../view/home_view.dart';

class DifficultySelector extends StatelessWidget {
  final CpuDifficulty selectedDifficulty;
  final Function(CpuDifficulty) onDifficultyChanged;
  const DifficultySelector(
      {super.key,
      required this.selectedDifficulty,
      required this.onDifficultyChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'DIFFICULTY:',
            style: TextStyle(
                color: AppColors.textLight, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: CpuDifficulty.values
              .map((e) => _DifficultyContainer(
                    difficulty: e,
                    isSelected: e == selectedDifficulty,
                    onDifficultyChanged: onDifficultyChanged,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _DifficultyContainer extends StatelessWidget {
  final CpuDifficulty difficulty;
  final Function(CpuDifficulty) onDifficultyChanged;
  final bool isSelected;
  const _DifficultyContainer({
    required this.difficulty,
    required this.onDifficultyChanged,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color color = _getDifficultyColor(difficulty);
    return GestureDetector(
      onTap: () => onDifficultyChanged(difficulty),
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(8),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? _getDifficultyColor(difficulty) : null,
        ),
        child: Center(
          child: Text(
            difficulty.name.toUpperCase(),
            style: TextStyle(
              color: isSelected ? AppColors.textDark : color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _getDifficultyColor(CpuDifficulty difficulty) {
    switch (difficulty) {
      case CpuDifficulty.easy:
        return AppColors.easyColor;
      case CpuDifficulty.medium:
        return AppColors.mediumColor;
      case CpuDifficulty.hard:
        return AppColors.hardColor;
    }
  }
}
