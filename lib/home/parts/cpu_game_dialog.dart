part of '../view/home_view.dart';

class CpuGameDialog extends StatelessWidget {
  const CpuGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    bool xMark = true;
    CpuDifficulty selectedDifficulty = CpuDifficulty.easy;
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        backgroundColor: AppColors.boxColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'PICK PLAYER MARK',
                  style: TextStyle(
                      color: AppColors.textLight, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _MarkSwitch(
                  xMark: xMark,
                  onChanged: () {
                    setState(() {
                      xMark = !xMark;
                    });
                  },
                ),
                const SizedBox(height: 40),
                const Text(
                  'Remember, X goes first',
                  style: TextStyle(
                    color: AppColors.textLight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DifficultySelector(
                      selectedDifficulty: selectedDifficulty,
                      onDifficultyChanged: (d) {
                        setState(() => selectedDifficulty = d);
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: CustomButton(
                      color: AppColors.secondary,
                      shadowColor: AppColors.secondaryShadow,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CpuGamePage(
                                      cpuValue: xMark ? 'O' : 'X',
                                      difficulty: selectedDifficulty,
                                    )));
                      },
                      child: const Text(
                        'PLAY',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _MarkSwitch extends StatelessWidget {
  final bool xMark;
  final Function() onChanged;
  const _MarkSwitch({required this.xMark, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: !xMark ? onChanged : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 100,
                  height: 50,
                  child: const Center(
                    child: Cross(
                      color: AppColors.buttonColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: xMark ? onChanged : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 100,
                  height: 50,
                  child: const Center(
                    child: Circle(
                      color: AppColors.buttonColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          alignment: xMark ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: xMark
                    ? const Cross(
                        color: AppColors.background,
                      )
                    : const Circle(
                        color: AppColors.background,
                      ),
              ))),
        )
      ],
    );
  }
}
