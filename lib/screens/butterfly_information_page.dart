import 'package:flutter/material.dart';
import '../data/butterfly_information_data.dart';
import '../widgets/butterfly_information/butterfly_hero_banner.dart';
import '../widgets/butterfly_information/expandable_section.dart';
import '../widgets/butterfly_information/floating_action_header.dart';



class ButterflyInformationPage extends StatefulWidget {
  final String vlinderSoort;

  const ButterflyInformationPage({super.key, required this.vlinderSoort});

  @override
  State<StatefulWidget> createState() => _ButterflyInformationPageState();
}

class _ButterflyInformationPageState extends State<ButterflyInformationPage> {
  @override
  Widget build(BuildContext context) {
    final vlinderSoortNaam = widget.vlinderSoort;

    final filteredButterflies = butterflyInformationData
        .where((vlinder) => vlinder.scientificName == vlinderSoortNaam)
        .toList();

    if (filteredButterflies.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text('No information available for this butterfly.'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final butterfly = filteredButterflies.first;

    return Scaffold(
      backgroundColor: const Color(0xFF0f172a),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ButterflyHeroBanner(butterfly: butterfly),
                _buildContentSection(butterfly),
              ],
            ),
          ),
          FloatingActionHeader(
            onBack: () => Navigator.pop(context),
            onShare: () {},
            onBookmark: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(butterfly) {
    return Container(
      color: const Color(0xFF0f172a),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ExpandableSection(
                  title: 'Physical Description',
                  content: butterfly.physicalDescription,
                  initiallyExpanded: true,
                ),
                const SizedBox(height: 8),
                ExpandableSection(
                  title: 'Early Stages (Larval)',
                  content: butterfly.physicalDescriptionLarvae,
                ),
                const SizedBox(height: 8),
                ExpandableSection(
                  title: 'Host Plants',
                  content: butterfly.foodPlants,
                ),
                const SizedBox(height: 8),
                ExpandableSection(
                  title: 'Distribution Areas',
                  content: butterfly.distributionAreasSuriname,
                ),
                const SizedBox(height: 32),
                Text(
                  'Source: Butterflies of Suriname',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
