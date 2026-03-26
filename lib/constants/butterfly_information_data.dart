// lib/constants/butterfly_information_data.dart
// Static seed data for butterfly detailed information.
// Extend this list with real data as needed.

import '../models/butterfly_information.dart';

// List holding detailed information entries. Ensure scientificName matches entries in butterflySpecies.
final List<ButterflyInformation> butterflyInformationData = [
  const ButterflyInformation(
    scientificName: 'Eurema albula',
    morphologicalCharacteristics: 'Small to medium-sized yellow sulphur. Upper side pale yellow with faint markings; underside whitish with subtle spots aiding camouflage.',
    hostPlants: 'Primarily Fabaceae (legume family); larvae often feed on Cassia / Senna species.',
    caterpillarCharacteristics: 'Slender green caterpillar with fine longitudinal lines providing leaf mimicry; smooth body surface.',
    surinameDistributionAreas: 'Common in open / disturbed areas, forest edges, secondary growth and gardens across much of Suriname.',
    imageFileName: 'Eurema albula.png',
  ),
  // Add more ButterflyInformation entries here...
];
