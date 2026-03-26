// lib/widgets/butterfly_information/butterfly_information_display.dart
import 'package:flutter/material.dart';
import '../../models/butterfly_information.dart';
import 'butterfly_information_property.dart';

class ButterflyInformationDisplay extends StatelessWidget {
  final ButterflyInformation vlinderSoortInformatie;

  const ButterflyInformationDisplay({super.key, required this.vlinderSoortInformatie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Butterfly species image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            vlinderSoortInformatie.imagePath,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ButterflyInformationProperty(
          attributeName: 'Wetenschappelijke naam',
          attributeValue: vlinderSoortInformatie.scientificName,
        ),
        ButterflyInformationProperty(
          attributeName: 'Morfologische kenmerken',
          attributeValue: vlinderSoortInformatie.morphologicalCharacteristics,
        ),
        ButterflyInformationProperty(
          attributeName: 'Waardplanten',
          attributeValue: vlinderSoortInformatie.hostPlants,
        ),
        ButterflyInformationProperty(
          attributeName: 'Rupskenmerken',
          attributeValue: vlinderSoortInformatie.caterpillarCharacteristics,
        ),
        ButterflyInformationProperty(
          attributeName: 'Surinaamse verspreidingsgebieden',
          attributeValue: vlinderSoortInformatie.surinameDistributionAreas,
        ),
      ],
    );
  }
}
