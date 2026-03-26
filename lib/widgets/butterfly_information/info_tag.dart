import 'package:flutter/material.dart';

class InfoTag extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;

  const InfoTag({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.borderColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: 1,
              )
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: label == label.toUpperCase() ? 1.5 : 0,
        ),
      ),
    );
  }
}
