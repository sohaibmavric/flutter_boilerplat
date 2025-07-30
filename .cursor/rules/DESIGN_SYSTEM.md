# Sikila Flutter Design System

This document outlines the design system, coding conventions, and architectural guidelines for the Sikila Flutter application. These rules should be strictly followed to ensure consistency, maintainability, and quality throughout the project.

## 1. Guiding Principles

- **Clarity and Readability**: Code should be self-documenting. Prioritize clear names for variables, functions, and classes.
- **Consistency**: Adhere to the rules in this document for a uniform codebase.
- **Performance**: Write efficient code. Use `const` widgets, lazy loading, and optimized state management.
- **Scalability**: Structure the project to easily accommodate new features and developers.
- **🚨 ZERO TOLERANCE**: NO hardcoded strings, colors, spacing, or non-theme elements allowed
- **🌐 Multilingual First**: Every UI string MUST come from localization files

## 2. Project Structure

We will adopt a screen-first project structure inside the `lib/` directory.

```
lib/
|-- app/
|   |-- app.dart             # Main application widget
|   |-- router/              # Navigation and routing
|   |-- theme/               # Theme definitions
|   |-- l10n/                # Localization files
|
|-- core/
|   |-- constants/           # App-wide constants
|   |-- services/            # Core services (API, etc.)
|   |-- utils/               # Utility functions
|   |-- widgets/             # Shared, reusable widgets
|
|-- screens/
|   |-- screen_name/
|   |   |-- data/
|   |   |   |-- models/
|   |   |   |-- repositories/
|   |   |   |-- providers/
|   |   |
|   |   |-- presentation/
|   |   |   |-- pages/
|   |   |   |-- widgets/
|   |   |   |-- state/         # BLoC, Cubit, or other state managers
|
|-- main.dart                # App entry point

assets/
|-- fonts/                   # Custom fonts
|-- images/                  # App images and graphics
|   |-- icons/               # Custom app icons
|   |-- illustrations/       # Illustrations and graphics
|   |-- logos/               # Brand logos
|   |-- backgrounds/         # Background images
|-- animations/              # Lottie/Rive animations
|-- data/                    # JSON/CSV data files
```

## 3. Coding Style & Conventions

- **Language**: Dart
- **Formatting**: Adhere to the rules defined in `analysis_options.yaml`. Run `dart format .` regularly.
- **Naming**:
    - `PascalCase` for classes, enums, and typedefs.
    - `camelCase` for variables, parameters, and method names.
    - `snake_case` for file and directory names.
- **Linting**: Use `flutter_lints` and enable additional rules in `analysis_options.yaml` for stricter static analysis.

## 4. Color Palette

All colors used in the app must be referenced from the central theme. Do not hardcode color values.

### Base Colors
| Name        | Hex       |
|-------------|-----------|
| White       | `#FFFFFF` |
| Black       | `#000000` |

### Brand Colors
| Name        | Hex       |
|-------------|-----------|
| Brand 25    | `#FCFAFF` |
| Brand 50    | `#F9F5FF` |
| Brand 100   | `#F4EBFF` |
| Brand 200   | `#E9D7FE` |
| Brand 300   | `#D6BBFB` |
| Brand 400   | `#B692F6` |
| Brand 500   | `#9E77ED` |
| Brand 600   | `#7F56D9` |
| Brand 700   | `#6941C6` |
| Brand 800   | `#53389E` |
| Brand 900   | `#42307D` |
| Brand 950   | `#2C1C5F` |

### Error Colors
| Name        | Hex       |
|-------------|-----------|
| Error 25    | `#FFFBFA` |
| Error 50    | `#FEF3F2` |
| Error 100   | `#FEE4E2` |
| Error 200   | `#FECDCA` |
| Error 300   | `#FDA29B` |
| Error 400   | `#F97066` |
| Error 500   | `#F04438` |
| Error 600   | `#D92D20` |
| Error 700   | `#B42318` |
| Error 800   | `#912018` |
| Error 900   | `#7A271A` |
| Error 950   | `#55160C` |

### Warning Colors
| Name        | Hex       |
|-------------|-----------|
| Warning 25  | `#FFFCF5` |
| Warning 50  | `#FFFAEB` |
| Warning 100 | `#FEF0C7` |
| Warning 200 | `#FEDF89` |
| Warning 300 | `#FEC84B` |
| Warning 400 | `#FDB022` |
| Warning 500 | `#F79009` |
| Warning 600 | `#DC6803` |
| Warning 700 | `#B54708` |
| Warning 800 | `#93370D` |
| Warning 900 | `#7A2E0E` |
| Warning 950 | `#4E1D09` |

### Success Colors
| Name        | Hex       |
|-------------|-----------|
| Success 25  | `#F6FEF9` |
| Success 50  | `#ECFDF3` |
| Success 100 | `#DCFAE6` |
| Success 200 | `#ABEFC6` |
| Success 300 | `#75E0A7` |
| Success 400 | `#47CD89` |
| Success 500 | `#17B26A` |
| Success 600 | `#079455` |
| Success 700 | `#067647` |
| Success 800 | `#085D3A` |
| Success 900 | `#074D31` |
| Success 950 | `#053321` |

## 5. Theming (Light & Dark)

We will define separate `ThemeData` for light and dark modes. The color palette will be mapped to the standard `ColorScheme`.

**Example `ThemeData` configuration:**

```dart
// lib/app/theme/theme.dart

import 'package:flutter/material.dart';

// Define your color constants here from the palette
const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF7F56D9), // Brand 600
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF9E77ED), // Brand 500
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFD92D20), // Error 600
  onError: Color(0xFFFFFFFF),
  background: Color(0xFFFFFFFF), // White
  onBackground: Color(0xFF000000), // Black
  surface: Color(0xFFFFFFFF), // White
  onSurface: Color(0xFF000000), // Black
  // ... map other colors
);

const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB692F6), // Brand 400
  onPrimary: Color(0xFF000000),
  secondary: Color(0xFF9E77ED), // Brand 500
  onSecondary: Color(0xFF000000),
  error: Color(0xFFF97066), // Error 400
  onError: Color(0xFF000000),
  background: Color(0xFF000000), // Black
  onBackground: Color(0xFFFFFFFF), // White
  surface: Color(0xFF000000), // Black
  onSurface: Color(0xFFFFFFFF), // White
  // ... map other colors
);

final lightTheme = ThemeData(colorScheme: _lightColorScheme, /* ... other theme properties */);
final darkTheme = ThemeData(colorScheme: _darkColorScheme, /* ... other theme properties */);
```

To use a theme color: `Theme.of(context).colorScheme.primary`.

## 6. Spacing & Layout

Use a consistent spacing scale for all margins, paddings, and gaps. This ensures visual harmony. The base unit is 4 pixels.

- `spaceXXS`: 2px
- `spaceXS`: 4px
- `spaceS`: 8px
- `spaceM`: 12px
- `spaceL`: 16px
- `spaceXL`: 24px
- `spaceXXL`: 32px
- `spaceXXXL`: 48px

Create a file `lib/core/constants/spacing.dart` with these values.

## 7. Typography

Define a `TextTheme` in `ThemeData` for all text styles. Use a scalable and readable font, such as Google Fonts' "Inter".

**Example `TextTheme` configuration:**

```dart
// Inside ThemeData
textTheme: const TextTheme(
  displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600),
  bodyLarge: TextStyle(fontSize: 16.0),
  labelSmall: TextStyle(fontSize: 11.0, letterSpacing: 0.5),
  // ... define all styles
),
```

To use a text style: `Theme.of(context).textTheme.bodyLarge`.

## 8. Fonts & Custom Typography

### Font Management
All fonts must be properly organized and declared in `pubspec.yaml`.

**Directory Structure:**
```
assets/
└── fonts/
    └── inter/
        ├── Inter-Regular.ttf
        ├── Inter-Medium.ttf
        ├── Inter-SemiBold.ttf
        └── Inter-Bold.ttf
```

**pubspec.yaml Configuration:**
```yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/inter/Inter-Regular.ttf
          weight: 400
        - asset: assets/fonts/inter/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/inter/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/inter/Inter-Bold.ttf
          weight: 700
```

### Font Usage Rules
- ✅ **Use Google Fonts package** when possible for better performance
- ✅ **Fallback fonts**: Always define fallback fonts in case custom fonts fail
- ✅ **Consistent weights**: Limit to 4-5 font weights maximum
- ❌ **Never hardcode**: Font families in individual widgets

## 9. Assets Management

### Directory Structure
```
assets/
├── fonts/              # Custom fonts
├── images/             # App images and graphics
│   ├── icons/          # Custom app icons
│   ├── illustrations/  # Illustrations and graphics
│   ├── logos/          # Brand logos
│   └── backgrounds/    # Background images
├── animations/         # Lottie/Rive animations
└── data/              # JSON/CSV data files
```

### Asset Declaration Rules
**pubspec.yaml:**
```yaml
flutter:
  assets:
    - assets/images/
    - assets/images/icons/
    - assets/images/illustrations/
    - assets/animations/
    - assets/data/
```

### Asset Naming Convention
- ✅ **snake_case**: `user_avatar_placeholder.png`
- ✅ **Descriptive names**: `onboarding_welcome_illustration.svg`
- ✅ **Size suffixes**: `logo_small.png`, `logo_large.png`
- ❌ **Generic names**: `image1.png`, `icon.svg`

## 10. Images & Graphics

### Image Formats & Optimization
- ✅ **SVG**: Vector graphics, icons, simple illustrations
- ✅ **PNG**: Images with transparency
- ✅ **JPEG**: Photos and complex images
- ✅ **WebP**: When supported, for better compression

### Image Size Guidelines
- ✅ **Multiple densities**: Provide @1x, @2x, @3x variants
- ✅ **Optimize sizes**: Keep images under 1MB
- ✅ **Lazy loading**: Implement for large image lists
- ✅ **Caching**: Use `cached_network_image` for network images

### Image Directory Structure
```
assets/images/
├── icons/
│   ├── ic_home.svg
│   ├── ic_profile.svg
│   └── ic_settings.svg
├── illustrations/
│   ├── onboarding_welcome.svg
│   └── empty_state_posts.svg
├── logos/
│   ├── app_logo.svg
│   ├── app_logo_small.png
│   └── splash_logo.png
└── backgrounds/
    ├── login_background.jpg
    └── profile_default_bg.png
```

### Image Usage Rules
```dart
// ✅ CORRECT - Using asset images
Image.asset(
  'assets/images/logos/app_logo.svg',
  width: 120,
  height: 40,
)

// ✅ CORRECT - Network images with caching
CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)

// ❌ WRONG - Hardcoded network images without caching
Image.network('https://example.com/image.jpg')
```

## 11. Icons & Iconography

### Icon System Guidelines
- ✅ **Material Icons**: Primary icon system
- ✅ **Custom SVG icons**: For brand-specific icons
- ✅ **Consistent style**: 24x24dp standard size
- ✅ **RTL support**: Mirror directional icons in RTL

### Icon Categories
```
assets/images/icons/
├── navigation/         # Bottom nav, drawer icons
│   ├── ic_home.svg
│   ├── ic_search.svg
│   └── ic_profile.svg
├── actions/           # Action buttons, FABs
│   ├── ic_add.svg
│   ├── ic_edit.svg
│   └── ic_delete.svg
├── status/            # Status indicators
│   ├── ic_success.svg
│   ├── ic_warning.svg
│   └── ic_error.svg
└── social/            # Social media icons
    ├── ic_facebook.svg
    ├── ic_twitter.svg
    └── ic_instagram.svg
```

### Icon Usage Rules
```dart
// ✅ CORRECT - Material Icons
Icon(
  Icons.home,
  size: 24,
  color: Theme.of(context).colorScheme.primary,
)

// ✅ CORRECT - Custom SVG icons
SvgPicture.asset(
  'assets/images/icons/navigation/ic_home.svg',
  width: 24,
  height: 24,
  colorFilter: ColorFilter.mode(
    Theme.of(context).colorScheme.primary,
    BlendMode.srcIn,
  ),
)

// ✅ CORRECT - Icon constants
class AppIcons {
  static const String home = 'assets/images/icons/navigation/ic_home.svg';
  static const String profile = 'assets/images/icons/navigation/ic_profile.svg';
  // ... more icons
}

// ❌ WRONG - Hardcoded paths in widgets
SvgPicture.asset('assets/images/icons/navigation/ic_home.svg')
```

### Icon Accessibility
- ✅ **Semantic labels**: Provide meaningful semantics
- ✅ **Touch targets**: Minimum 48x48dp for interactive icons
- ✅ **Color contrast**: Ensure sufficient contrast ratios
- ✅ **Alternative text**: For screen readers

## 12. Internationalization (i18n) & RTL Support

The app must support multiple languages, including Right-to-Left (RTL) languages like Arabic.

### 🚨 ABSOLUTE ZERO TOLERANCE FOR HARDCODED STRINGS 🚨

**INSTANT CODE REJECTION FOR:**
```dart
// ❌ FORBIDDEN - Any hardcoded UI strings
Text('Dashboard')
Text('Statistics Overview')
Text('Total Users')
Text('$45.2K')
Text('Create Post')
AppBar(title: Text('Settings'))
SnackBar(content: Text('Success'))
```

**MANDATORY LOCALIZATION USAGE:**
```dart
// ✅ REQUIRED - All UI strings from l10n
Text(l10n.dashboard)
Text(l10n.statisticsOverview)
Text(l10n.totalUsers)
Text(l10n.revenue)
AppBar(title: Text(l10n.settings))
SnackBar(content: Text(l10n.success))
```

### Setup & Requirements
1.  **Setup**: Use the `flutter_localizations` package and follow the official Flutter internationalization guide.
2.  **Strings**: ALL user-facing strings must be stored in `.arb` files and retrieved using a localization delegate. ZERO exceptions.
3.  **Pre-commit validation**: Run automated checks to detect hardcoded strings
4.  **Layout for RTL**: Flutter handles most RTL layout automatically.
    - Use `EdgeInsetsDirectional` for padding/margin that should adapt to text direction.
    - `Row` and `Column` automatically reverse their children in RTL.
    - Be mindful of icons that imply direction (e.g., back arrows). They may need to be mirrored.

### Automated Detection
```bash
# These commands MUST return ZERO results for UI code:
grep -r "Text('.*')" lib/ 
grep -r 'Text(".*")' lib/
grep -r "title: Text('.*')" lib/
grep -r 'content: Text(' lib/
```

**REMEMBER: No hardcoded strings means NO EXCEPTIONS. Quality and internationalization are non-negotiable.**

By following these rules strictly, we will build a robust, beautiful, and maintainable multilingual application.
