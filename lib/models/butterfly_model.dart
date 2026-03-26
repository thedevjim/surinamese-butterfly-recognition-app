class ButterflyInformation {
  final String scientificName;
  final String family;// Made optional as it will be removed
  final String physicalDescription;
  final String foodPlants;
  final String distributionAreasSuriname;
  final String imagePath;
  final String physicalDescriptionLarvae; // Changed from imageUrl to imagePath

  const ButterflyInformation({
    required this.scientificName,
    required this.family,
    required this.physicalDescription,
    required this.physicalDescriptionLarvae,
    required this.foodPlants,
    required this.distributionAreasSuriname,
    required this.imagePath,
  });
}
