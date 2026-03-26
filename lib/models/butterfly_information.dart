// lib/models/butterfly_information.dart
// Model representing detailed butterfly information.

class ButterflyInformation {
  final String scientificName; // Wetenschappelijke naam
  final String morphologicalCharacteristics; // Morfologische kenmerken
  final String hostPlants; // Waardplanten
  final String caterpillarCharacteristics; // Rupskenmerken
  final String surinameDistributionAreas; // Surinaamse verspreidingsgebieden
  final String imageFileName; // Butterfly species image filename

  const ButterflyInformation({
    required this.scientificName,
    required this.morphologicalCharacteristics,
    required this.hostPlants,
    required this.caterpillarCharacteristics,
    required this.surinameDistributionAreas,
    required this.imageFileName,
  });

  // Getter that returns the full asset path
  String get imagePath => 'assets/preview_vlindersoorten/$imageFileName';
}
