import 'dart:developer' as devtools;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';


class ButterflyAIService {
  late Interpreter interpreter;
  IsolateInterpreter? isolateInterpreter;

  Future<void> initInterpreter() async {
    try {
      interpreter =
          await Interpreter.fromAsset('assets/butterfly-recognition-model.tflite');
      isolateInterpreter =
          await IsolateInterpreter.create(address: interpreter.address);
    } catch (e) {
      devtools.log("Error loading model: $e");
    }
  }

  Future<Map<String, dynamic>> recognizeButterfly(
      File imageFile, int numberOfButterflySpecies) async {
    var inputDetails = interpreter.getInputTensor(0);
    var inputShape = inputDetails.shape;

    final imageFileBytes = await imageFile.readAsBytes();

    final Float32List inputBytes = await compute(
      _preprocessImageToFloat32,
      <String, Object>{
        'bytes': imageFileBytes,
        'targetWidth': inputShape[1],
        'targetHeight': inputShape[2],
      },
    );

    final input = inputBytes.reshape([1, inputShape[1], inputShape[2], 3]);

    // Output container
    final output = Float32List(1 * numberOfButterflySpecies).reshape([1, numberOfButterflySpecies]);

    // --- Hier vind inferentie plaats. De tijd hiervoor zal gemeten worden en getoond worden op de UI ---
    final stopwatch = Stopwatch()..start();
    if (isolateInterpreter != null) {
      await isolateInterpreter!.run(input, output);
    } else {
      interpreter.run(input, output);
    }
    stopwatch.stop();
    final inferenceTimeMs = stopwatch.elapsedMilliseconds;
    devtools.log("Inference Time: ${inferenceTimeMs}ms");
    // --- End Measurement ---

// de output welke het model geeft is lijst met confidence scores voor alle vlindersoorten
    var volledigeOutputTensor = output[0];

    devtools.log(volledigeOutputTensor.toString());
//
    final predictionResult = volledigeOutputTensor as List<double>;

    // van de lijst met confidence scores wordt de hoogste score gepakt en
    // de vlindersoort tot welke deze toebehoort
    double maxElement = predictionResult.reduce(
      (double maxElement, double element) =>
          element > maxElement ? element : maxElement,
    );

    int maxIndex = predictionResult.indexOf(maxElement);
    return {
      'confidence': maxElement,
      'positionModelOutput': maxIndex,
      'inferenceTimeMs': inferenceTimeMs,
    };
  }

  void closeInterpreter() {
    isolateInterpreter?.close();
    interpreter.close();
  }
}

Float32List _preprocessImageToFloat32(Map<String, Object> request) {
  final bytes = request['bytes']! as Uint8List;
  final targetWidth = request['targetWidth']! as int;
  final targetHeight = request['targetHeight']! as int;

  final imageDecoded = img.decodeImage(bytes)!;
  final resizedImage = img.copyResize(
    imageDecoded,
    width: targetWidth,
    height: targetHeight,
  );

  final inputBytes =
      Float32List(1 * targetWidth * targetHeight * 3);
  final imageBytes = resizedImage.getBytes();

  for (int i = 0; i < imageBytes.length; i++) {
    inputBytes[i] = imageBytes[i].toDouble();
  }

  return inputBytes;
}
