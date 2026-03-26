import 'package:flutter/material.dart';

class FloatingActionHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;

  const FloatingActionHeader({
    super.key,
    required this.onBack,
    this.onShare,
    this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _FloatingIconButton(
                icon: Icons.arrow_back,
                onPressed: onBack,
              ),
              Row(
                children: [
                  if (onShare != null)
                    _FloatingIconButton(
                      icon: Icons.share,
                      onPressed: onShare!,
                    ),
                  if (onShare != null && onBookmark != null)
                    const SizedBox(width: 12),
                  if (onBookmark != null)
                    _FloatingIconButton(
                      icon: Icons.bookmark,
                      iconColor: const Color(0xFF0364E9),
                      onPressed: onBookmark!,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;

  const _FloatingIconButton({
    required this.icon,
    required this.onPressed,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
      ),
    );
  }
}
