# Sikila Flutter App

A professionally developed Flutter mobile application with comprehensive design system, internationalization support (including Arabic RTL), and strict development standards.

## 🏗️ Project Structure

```
sikila/
├── .cursor/                    # Cursor IDE configuration and rules
│   ├── DESIGN_SYSTEM.md       # Complete design system documentation
│   ├── rules                  # Main Cursor AI rules
│   ├── instructions.md        # Developer guidelines
│   ├── composer.md           # Cursor Composer rules
│   ├── settings.json         # IDE settings
│   ├── prompts.md           # Quick reference prompts
│   ├── snippets.json        # Custom code snippets
│   └── README.md            # Configuration documentation
├── lib/                     # Main application code
│   ├── app/                # App-level configuration
│   ├── core/               # Shared utilities and constants
│   ├── features/           # Feature-specific modules
│   └── main.dart          # Application entry point
├── test/                   # Test files
├── l10n.yaml              # Localization configuration
└── pubspec.yaml           # Dependencies and project config
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Cursor IDE (recommended) or VS Code

### Setup
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter gen-l10n` to generate localization files
4. Run `flutter run` to start the app

### Development with Cursor IDE
The project includes comprehensive Cursor IDE configuration in the `.cursor/` directory that:
- Enforces design system compliance
- Ensures RTL and internationalization support
- Maintains code quality standards
- Provides helpful snippets and prompts

## 🎨 Design System

The complete design system is documented in `.cursor/DESIGN_SYSTEM.md`, including:
- **Color Palette**: Brand, error, warning, and success color scales
- **Typography**: Google Fonts Poppins with Material 3 text styles
- **Spacing**: Consistent 4px-based spacing scale
- **Theming**: Light and dark mode support
- **RTL Support**: Full Arabic language and layout support

## 🌍 Internationalization

- **Languages**: English (en) and Arabic (ar)
- **RTL Support**: Complete right-to-left layout support
- **Auto-generation**: Flutter's gen-l10n for type-safe translations

## 🧪 Testing

Run tests with:
```bash
flutter test                 # Unit and widget tests
flutter analyze             # Static analysis
flutter build web          # Build verification
```

## 📚 Documentation

- **Design System**: `.cursor/DESIGN_SYSTEM.md`
- **Development Guide**: `.cursor/instructions.md`
- **Cursor Configuration**: `.cursor/README.md`
- **Quick References**: `.cursor/prompts.md`

## 🔧 Development Commands

```bash
# Generate localization files
flutter gen-l10n

# Run static analysis
flutter analyze

# Format code
dart format .

# Run tests
flutter test

# Build for web
flutter build web
```

## 📱 Features

- **Professional Design System**: Comprehensive color, typography, and spacing guidelines
- **Internationalization**: Full support for multiple languages including Arabic RTL
- **Code Quality**: Enforced standards with automated checking
- **Performance Optimized**: Best practices for Flutter performance
- **Accessibility**: Built-in accessibility support
- **Testing**: Comprehensive test coverage

## 👥 Contributing

All development must follow the guidelines in `.cursor/instructions.md`. The Cursor IDE configuration automatically enforces our standards.

## 📄 License

This project is part of the Sikila application development.