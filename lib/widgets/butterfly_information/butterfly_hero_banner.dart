import 'package:flutter/material.dart';
import 'package:myapp/models/butterfly_model.dart';
import 'info_tag.dart';
import 'fullscreen_image_viewer.dart';

class ButterflyHeroBanner extends StatelessWidget {
  final ButterflyInformation butterfly;

  const ButterflyHeroBanner({
    super.key,
    required this.butterfly,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FullscreenImageViewer.show(
        context,
        imagePath: butterfly.imagePath,
        semanticLabel: 'Full size image of ${butterfly.scientificName}',
      ),
      child: Semantics(
        button: true,
        label: 'Tap to view full size image of ${butterfly.scientificName}',
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                butterfly.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade800,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF0f172a).withOpacity(0.3),
                      const Color(0xFF0f172a),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.zoom_in,
                        color: Colors.white.withOpacity(0.9),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'View',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          InfoTag(
                            label: 'COMMON',
                            backgroundColor: const Color(0xFF0364E9).withOpacity(0.9),
                          ),
                          InfoTag(
                            label: butterfly.family,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            borderColor: Colors.white.withOpacity(0.1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        butterfly.scientificName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        butterfly.scientificName,
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
