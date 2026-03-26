import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraTopBar extends StatelessWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onHistoryPressed;
  final VoidCallback onFlashToggle;
  final FlashMode flashMode;

  const CameraTopBar({
    super.key,
    required this.onMenuPressed,
    required this.onHistoryPressed,
    required this.onFlashToggle,
    required this.flashMode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircularIconButton(
            icon: Icons.menu,
            onPressed: onMenuPressed,
            backgroundColor: Colors.black.withOpacity(0.6),
          ),
          Row(
            children: [
              _CircularIconButton(
                icon: Icons.link,
                onPressed: onHistoryPressed,
                backgroundColor: Colors.white.withOpacity(0.3),
              ),
              const SizedBox(width: 12),
              _CircularIconButton(
                icon: _mapFlashModeToIcon(flashMode),
                onPressed: onFlashToggle,
                backgroundColor: Colors.white.withOpacity(0.3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

IconData _mapFlashModeToIcon(FlashMode mode) {
  if (mode == FlashMode.off) {
    return Icons.flash_off;
  }
  if (mode == FlashMode.auto) {
    return Icons.flash_auto;
  }
  return Icons.flash_on;
}

class _CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const _CircularIconButton({
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        iconSize: 24,
      ),
    );
  }
}
