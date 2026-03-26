# Surinaamse Vlinderherkennings App

**AI-powered butterfly species identification app for Suriname's native butterflies**

A Flutter mobile application that uses machine learning to identify butterfly species native to Suriname through camera capture or photo upload. The app provides instant species recognition with confidence scores and detailed information about each butterfly species.




<div align="center">

https://github.com/user-attachments/assets/f564fd00-3696-4a53-b79b-4f82b4c20675

</div>



---

## Features

- **Real-time Camera Recognition** - Capture photos directly through the app's camera interface with live preview
- **Gallery Upload** - Upload existing photos from your device's gallery for identification
- **AI-Powered Identification** - TensorFlow Lite model trained on Surinamese butterfly species
- **Confidence Scoring** - Visual confidence percentage display for each identification
- **Species Library** - Browse and search through a comprehensive database of butterfly species
- **Detailed Species Information** - View scientific names, physical descriptions, food plants, and distribution areas
- **Modern UI/UX** - Clean, intuitive interface with Material Design 3 and custom theming

---

## Tech Stack & Architecture

### Core Technologies
- **Flutter SDK**: `>=3.4.3 <4.0.0`
- **Dart**: Language for Flutter development
- **TensorFlow Lite**: On-device machine learning inference (`tflite_flutter: ^0.11.0`)

### Key Dependencies
- **UI & Theming**
  - `google_fonts: ^6.3.0` - Custom typography (Open Sans)
  - `loading_animation_widget: ^1.3.0` - Loading indicators
  - `cupertino_icons: ^1.0.6` - iOS-style icons

- **Camera & Media**
  - `camera: ^0.10.6` - Camera access and preview
  - `image_picker: ^1.1.2` - Gallery image selection
  - `permission_handler: ^11.4.0` - Runtime permissions
  - `image: ^4.2.0` - Image preprocessing

- **Data & Storage**
  - `sqflite: ^2.4.0` - Local SQLite database
  - `path_provider: ^2.1.5` - File system paths
  - `path: ^1.9.0` - Path manipulation

### Architecture Pattern
- **Feature-based folder structure** with clear separation of concerns:
  - `screens/` - UI screens and navigation
  - `services/` - Business logic (AI inference, image picking)
  - `models/` - Data models
  - `widgets/` - Reusable UI components
  - `data/` - Static data and constants
  - `constants/` - App-wide constants

- **State Management**: StatefulWidget with local state management
- **AI Inference**: Isolated compute for non-blocking image preprocessing
- **Navigation**: Material PageRoute-based navigation

---

## Setup and Usage

### Prerequisites

Before running this app, ensure you have:

1. **Flutter SDK** (version 3.4.3 or higher)
   - [Install Flutter](https://docs.flutter.dev/get-started/install)
   - Verify installation: `flutter doctor`

2. **Development Environment**
   - **Android**: Android Studio with Android SDK
   - **iOS**: Xcode (macOS only)
   - **Supported platforms**: Android, iOS, Web

3. **Device/Emulator Requirements**
   - Camera permission support
   - Minimum Android SDK: Check `android/app/build.gradle`
   - iOS deployment target: Check `ios/Podfile`

### Installation & Running

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd surinaamse-vlinderherkennings-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify TensorFlow Lite model**
   - Ensure the model file exists at: `assets/butterfly-recognition-model.tflite`
   - Model is automatically bundled with the app

4. **Run the app**
   ```bash
   # Run on connected device/emulator
   flutter run
   
   # Run on specific device
   flutter devices
   flutter run -d <device-id>
   
   # Run in release mode for better performance
   flutter run --release
   ```

5. **Build for production**
   ```bash
   # Android APK
   flutter build apk --release
   
   # Android App Bundle
   flutter build appbundle --release
   
   # iOS
   flutter build ios --release
   ```

### Configuration

#### Camera Permissions

The app requires camera and storage permissions. These are automatically requested at runtime.

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to identify butterflies</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to identify butterflies from your photos</string>
```

#### Model Configuration

The TensorFlow Lite model is located at:
- Path: `assets/butterfly-recognition-model.tflite`
- Input shape: Dynamically read from model
- Output: Confidence scores for all butterfly species

To use a different model:
1. Replace the `.tflite` file in `assets/`
2. Update the model path in `lib/services/butterfly_ai_service.dart`:
   ```dart
   interpreter = await Interpreter.fromAsset('assets/your-model.tflite');
   ```

---

## Usage Examples

### Main User Flows

1. **Identify a Butterfly via Camera**
   - Open the app → Home screen displays
   - Tap "Take Photo" or tap the camera preview area
   - Camera captures the butterfly image
   - AI processes the image (loading indicator shown)
   - Results screen displays species name, confidence score, and preview
   - Tap "View Full Profile" for detailed information

2. **Identify from Gallery**
   - Open the app → Home screen
   - Tap "Upload" button
   - Select an image from your gallery
   - AI processes and displays results

3. **Browse Species Library**
   - Navigate to "Library" tab in bottom navigation
   - Browse all available butterfly species
   - Use search bar to filter by scientific name or family
   - Tap any species to view detailed information

4. **View Species Details**
   - From results or library, access species information page
   - View scientific name, family, physical description
   - Learn about food plants and distribution areas in Suriname
   - See reference images

---

## Project Structure

```
lib/
├── main.dart                          # App entry point, theme configuration
├── constants/
│   └── butterfly_species.dart         # List of butterfly species names
├── data/
│   └── butterfly_information_data.dart # Static butterfly information database
├── models/
│   └── butterfly_model.dart           # ButterflyInformation data model
├── screens/
│   ├── main_navigation.dart           # Bottom navigation container
│   ├── home_screen.dart               # Camera/scan interface
│   ├── results_screen.dart            # Recognition results display
│   ├── library_screen.dart            # Species browsing/search
│   └── butterfly_information_page.dart # Detailed species info
├── services/
│   ├── butterfly_ai_service.dart      # TensorFlow Lite inference
│   └── image_picker_service.dart      # Gallery image selection
└── widgets/
    └── butterfly_information/
        └── butterfly_information_display.dart # Species info components

assets/
├── butterfly-recognition-model.tflite          # TensorFlow Lite model
├── butterfly_images/                   # Species reference images
└── upload.jpg                          # Placeholder image
```

---

## Testing

### Run Unit Tests
```bash
flutter test
```

### Run Widget Tests
```bash
flutter test test/widget_test.dart
```

### Test Coverage
```bash
flutter test --coverage
```

### Manual Testing Checklist
- [ ] Camera permission request works
- [ ] Camera preview displays correctly
- [ ] Photo capture functions properly
- [ ] Gallery upload works
- [ ] AI inference completes without errors
- [ ] Results display with correct confidence scores
- [ ] Navigation between screens works
- [ ] Search in library filters correctly
- [ ] Species detail pages load properly

---

## Development

### Code Style
This project follows Flutter's official style guide and uses `flutter_lints: ^3.0.0` for linting.

Run linter:
```bash
flutter analyze
```

Format code:
```bash
flutter format .
```

### Adding New Butterfly Species

1. Add species name to `lib/constants/butterfly_species.dart`
2. Add species information to `lib/data/butterfly_information_data.dart`
3. Add reference image to `assets/butterfly_images/`
4. Update model if needed (retrain with new species)

### Debugging

Enable verbose logging:
```dart
import 'dart:developer' as devtools;
devtools.log('Your debug message');
```

Check logs:
```bash
flutter logs
```

---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow Flutter style guide
- Add tests for new features
- Update documentation as needed
- Ensure `flutter analyze` passes with no errors
- Test on both Android and iOS if possible

---

## Known Issues & Limitations

- Model accuracy depends on image quality and lighting conditions
- Camera preview may have slight delay on older devices
- Some butterfly species may have similar visual features leading to misidentification
- Requires good internet connection for initial setup (downloading dependencies)

---

## Acknowledgements

- **TensorFlow Lite** for on-device machine learning capabilities
- **Flutter Team** for the excellent cross-platform framework
- **Google Fonts** for Open Sans typography
- Butterfly species data sourced from Surinamese biodiversity research

---

## License

This project is private and not currently licensed for public distribution.

---

## Contact & Support

For questions, issues, or contributions, please open an issue in the repository.

---

**Built with ❤️ for Suriname's biodiversity conservation**
