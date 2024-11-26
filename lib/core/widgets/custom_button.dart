import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color color;
  final Color shadowColor;
  final Function() onPressed;
  final Widget child;
  const CustomButton(
      {super.key,
      required this.color,
      required this.shadowColor,
      required this.onPressed,
      required this.child});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  tapDown() {
    setState(() => _isPressed = true);
  }

  tapUp() {
    setState(() => _isPressed = false);
  }

  tap() {
    tapDown();
    Future.delayed(const Duration(milliseconds: 200), () {
      tapUp();
      widget.onPressed()!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      onLongPress: () => tap(),
      onLongPressDown: (details) {
        tapDown();
      },
      onLongPressUp: () {
        tapUp();
        widget.onPressed();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
          border: _isPressed
              ? null
              : Border(
                  bottom: BorderSide(
                      color: !_isPressed ? widget.shadowColor : widget.color,
                      width: 4),
                ),
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}
