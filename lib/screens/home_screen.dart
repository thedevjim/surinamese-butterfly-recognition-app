import 'dart:developer' as devtools;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/services/butterfly_ai_service.dart';
import 'package:myapp/screens/results_screen.dart';

import '../constants/butterfly_species.dart';
import '../services/image_picker_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  bool _isRecognizing = false;

  final ButterflyAIService butterflyAIService = ButterflyAIService();
  final ImagePickerService imagePickerService = ImagePickerService();

  @override
  void initState() {
    super.initState();
    devtools.log('HomeScreen.initState() called');
    _initialize();
  }

  Future<void> _initialize() async {
    devtools.log('HomeScreen._initialize() start');
    await butterflyAIService.initInterpreter();
    devtools.log('HomeScreen._initialize() after initInterpreter');
  }

  Future<void> _takePhoto() async {
    try {
      devtools.log('HomeScreen._takePhoto() opening native camera...');
      final File? imageFile = await imagePickerService.takePictureWithCamera();
      if (imageFile != null) {
        devtools
            .log('HomeScreen._takePhoto() image captured: ${imageFile.path}');
        setState(() {
          _selectedImage = imageFile;
        });
      }
    } catch (e) {
      devtools.log('Error taking photo: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      devtools.log('HomeScreen._pickImageFromGallery() opening gallery...');
      final File? imageFile = await imagePickerService.pickImageFromGallery();
      if (imageFile != null) {
        devtools.log(
            'HomeScreen._pickImageFromGallery() image selected: ${imageFile.path}');
        setState(() {
          _selectedImage = imageFile;
        });
      }
    } catch (e) {
      devtools.log('Error picking image: $e');
    }
  }

  Future<void> _identifyButterfly() async {
    if (_selectedImage == null) return;

    try {
      if (mounted) {
        setState(() {
          _isRecognizing = true;
        });
      }
      devtools.log(
          'HomeScreen._identifyButterfly() start for file=${_selectedImage!.path}');
      final result = await butterflyAIService.recognizeButterfly(
          _selectedImage!, butterflySpecies.length);
      devtools.log('HomeScreen._identifyButterfly() received result: $result');
      final indexModelOutput = result['positionModelOutput'];
      final maxElement = result['confidence'];
      final timeMs = result['inferenceTimeMs'];

      if (indexModelOutput >= 0 && indexModelOutput < butterflySpecies.length) {
        final recognizedSpecies = butterflySpecies[indexModelOutput];
        devtools.log('Recognized: $recognizedSpecies');
        devtools.log('Confidence: ${maxElement.toString()}');
        devtools.log('Inference time: ${timeMs}ms');

        if (mounted) {
          final shouldClearImage = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(
                speciesName: recognizedSpecies,
                confidence: maxElement * 100,
                imageFile: _selectedImage!,
              ),
            ),
          );

          if (shouldClearImage == true && mounted) {
            setState(() {
              _selectedImage = null;
            });
          }
        }
      } else {
        devtools
            .log('Error: Invalid index from model output: $indexModelOutput');
      }
    } catch (e) {
      devtools.log('Error during recognition: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isRecognizing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    butterflyAIService.closeInterpreter();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTitle(),
                        _buildScanArea(),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_isRecognizing)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF0364E9)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF0364E9).withOpacity(0.2),
                width: 2,
              ),
              color: Colors.grey.shade200,
            ),
            child: Icon(
              Icons.person,
              color: Colors.grey.shade600,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                'Explorer',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
                height: 1.2,
              ),
              children: const [
                TextSpan(text: 'Identify a '),
                TextSpan(
                  text: 'Butterfly',
                  style: TextStyle(color: Color(0xFF0364E9)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap below or snap a photo to identify species native to Suriname.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 340),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  if (_selectedImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox.expand(
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (_selectedImage == null)
                    Center(
                      child: Text(
                        'No image selected',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCornerBrackets() {
    const bracketSize = 32.0;
    const bracketThickness = 4.0;
    const bracketColor = Color(0xFF0364E9);

    return Stack(
      children: [
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            width: bracketSize,
            height: bracketSize,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: bracketColor, width: bracketThickness),
                left: BorderSide(color: bracketColor, width: bracketThickness),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            width: bracketSize,
            height: bracketSize,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: bracketColor, width: bracketThickness),
                right: BorderSide(color: bracketColor, width: bracketThickness),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Container(
            width: bracketSize,
            height: bracketSize,
            decoration: const BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: bracketColor, width: bracketThickness),
                left: BorderSide(color: bracketColor, width: bracketThickness),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            width: bracketSize,
            height: bracketSize,
            decoration: const BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: bracketColor, width: bracketThickness),
                right: BorderSide(color: bracketColor, width: bracketThickness),
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScanLine() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 3),
      builder: (context, value, child) {
        return Positioned(
          left: 16,
          right: 16,
          top: 16 + (MediaQuery.of(context).size.width - 48 - 32) * value,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: const Color(0xFF0364E9),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0364E9).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
      onEnd: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          if (_selectedImage != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _identifyButterfly,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0364E9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFF0364E9).withOpacity(0.3),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Identify Butterfly',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _takePhoto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedImage == null
                        ? const Color(0xFF0364E9)
                        : Colors.white,
                    foregroundColor: _selectedImage == null
                        ? Colors.white
                        : const Color(0xFF0364E9),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: _selectedImage != null
                        ? BorderSide(
                            color: const Color(0xFF0364E9).withOpacity(0.2))
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: _selectedImage == null ? 4 : 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_camera, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        _selectedImage == null ? 'Take Photo' : 'Retake',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: _pickImageFromGallery,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0364E9),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                      color: const Color(0xFF0364E9).withOpacity(0.2),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue.shade50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_photo_alternate, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        _selectedImage == null ? 'Upload' : 'Reupload',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
