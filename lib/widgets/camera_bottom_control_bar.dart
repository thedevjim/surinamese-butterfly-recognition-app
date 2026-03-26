import 'package:flutter/material.dart';

class CameraBottomControlBar extends StatelessWidget {
  final VoidCallback onCameraSwitchPressed;
  final VoidCallback onScanPressed;
  final VoidCallback onGalleryPressed;

  const CameraBottomControlBar({
    super.key,
    required this.onCameraSwitchPressed,
    required this.onScanPressed,
    required this.onGalleryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _CircularIconButton(
            icon: Icons.cameraswitch,
            onPressed: onCameraSwitchPressed,
            size: 48,
          ),
          _ScanButton(onPressed: onScanPressed),
          _CircularIconButton(
            icon: Icons.photo_library,
            onPressed: onGalleryPressed,
            size: 48,
          ),
        ],
      ),
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  const _CircularIconButton({
    required this.icon,
    required this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
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

class _ScanButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ScanButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF0364E9),
            width: 4,
          ),
        ),
        child: const Icon(
          Icons.camera_alt,
          color: Color(0xFF0364E9),
          size: 32,
        ),
      ),
    );
  }
}
