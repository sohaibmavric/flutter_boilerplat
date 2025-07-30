# Sikila Flutter Project - Comprehensive Rules & Guidelines

🚨 **THESE RULES ARE NON-NEGOTIABLE AND MUST BE STRICTLY FOLLOWED** 🚨

You are an expert Flutter developer working on the Sikila mobile application. Every decision, every line of code, and every architectural choice MUST align with these rules.

## 🎯 Core Principles (MANDATORY)

1. **Design System First**: Every decision must follow the established design system
2. **Zero Tolerance for Violations**: Any code violating these rules MUST be rejected
3. **RTL & i18n Ready**: All UI must support Arabic (RTL) and multiple languages
4. **Performance & Quality**: Write efficient, bug-free, maintainable code
5. **Consistency Above All**: Maintain uniformity across the entire codebase

## 📁 Project Structure (STRICTLY ENFORCED)

```
lib/
├── app/
│   ├── app.dart                # Main application widget
│   ├── router/                 # Navigation and routing
│   ├── theme/                  # Theme definitions
│   └── l10n/                   # Localization files
├── core/
│   ├── constants/              # App-wide constants (spacing, etc.)
│   ├── services/               # Core services (API, state, etc.)
│   ├── utils/                  # Utility functions
│   └── widgets/                # Shared, reusable widgets
├── screens/
│   └── screen_name/
│       ├── data/
│       │   ├── models/
│       │   ├── repositories/
│       │   └── providers/
│       └── presentation/
│           ├── pages/
│           ├── widgets/
│           └── state/          # State management
└── main.dart                   # App entry point
```

## 🎨 Design System Compliance (ZERO TOLERANCE)

### Colors - ABSOLUTE RULES
- ❌ **NEVER hardcode colors**: `Color(0xFF...)`, `Colors.red`, etc.
- ✅ **ONLY use**: `Theme.of(context).colorScheme.*`
- ✅ **Reference**: Brand, Error, Warning, Success color palettes only

### Spacing - MANDATORY USAGE
- ❌ **NEVER hardcode spacing**: `EdgeInsets.all(16)`, `SizedBox(height: 20)`
- ✅ **ONLY use**: `AppSpacing` constants from `lib/core/constants/spacing.dart`
- ✅ **Available values**: spaceXXS(2), spaceXS(4), spaceS(8), spaceM(12), spaceL(16), spaceXL(24), spaceXXL(32), spaceXXXL(48)

### Typography - STRICT ENFORCEMENT
- ❌ **NEVER hardcode text styles**: `TextStyle(fontSize: 16)`
- ✅ **ONLY use**: `Theme.of(context).textTheme.*`
- ✅ **Font family**: Google Fonts "Inter" (defined in theme)

## 🌐 Internationalization (ZERO TOLERANCE POLICY)

### 🚨 CRITICAL: ABSOLUTELY NO HARDCODED STRINGS ALLOWED 🚨

**INSTANT REJECTION CRITERIA:**
- ❌ Any string literals in UI: `'Hello'`, `"Welcome"`, `'Loading...'`, `'Statistics Overview'`
- ❌ String concatenation in widgets: `'Hello ' + name`
- ❌ Template strings in UI: `'Count: $count'`, `'$45.2K'`, `'+12%'`
- ❌ Any user-visible text not from localization
- ❌ Hardcoded labels: `'Total Users'`, `'Revenue'`, `'Create Post'`
- ❌ Hardcoded descriptions: `'Add new content'`, `'User administration'`

### 🔍 AUTOMATED DETECTION COMMANDS
```bash
# These commands MUST return ZERO results:
grep -r "Text('.*')" lib/
grep -r 'Text(".*")' lib/
grep -r "title: Text('.*')" lib/
grep -r 'SnackBar.*Text(' lib/
```

**MANDATORY STRING USAGE:**
- ✅ **ONLY use**: `AppLocalizations.of(context)!.stringKey`
- ✅ **ALL strings must exist in**: `app_en.arb` and `app_ar.arb`
- ✅ **Before coding**: Verify strings exist in `.arb` files

**WHAT MUST BE LOCALIZED (NO EXCEPTIONS):**
- Button text, labels, titles, descriptions
- Error/success/loading messages
- Placeholder text, tooltips
- Any text visible to users

## 🎛️ Widget Development Standards

### Component Requirements
- ✅ **Standalone components**: All widgets must be self-contained
- ✅ **const constructors**: Use whenever possible
- ✅ **Proper keys**: Implement `Key` usage for widgets
- ✅ **RTL support**: Use `EdgeInsetsDirectional`, `Positioned.directional`

### Button Standards (MANDATORY)
- ✅ **Only use**: `FilledButton` (primary) and `OutlinedButton` (secondary)
- ✅ **Full width by default**: Wrap in `SizedBox(width: double.infinity)`
- ✅ **Border radius**: 4px (little radius as requested)
- ✅ **Consistent padding**: Use theme-defined padding

## 📱 Layout & RTL Support (MANDATORY)

### RTL Requirements
- ✅ **Use**: `EdgeInsetsDirectional` instead of `EdgeInsets`
- ✅ **Use**: `Positioned.directional` instead of `Positioned`
- ✅ **Test**: All layouts in both LTR and RTL modes
- ✅ **Direction awareness**: Use `Directionality.of(context)` when needed

## 🔧 Code Quality Standards

### Naming Conventions (STRICT)
- ✅ **Classes/enums/typedefs**: `PascalCase`
- ✅ **Variables/methods/parameters**: `camelCase`
- ✅ **Files/directories**: `snake_case`
- ✅ **Constants**: `kCamelCase` or `SCREAMING_SNAKE_CASE`

### File Organization
- ✅ **One main class per file**
- ✅ **Group related imports**: Flutter, packages, project files
- ✅ **Relative imports**: For project files
- ✅ **Barrel exports**: For feature modules

### Performance Requirements
- ✅ **const widgets**: Use whenever possible
- ✅ **Lazy loading**: Implement for lists
- ✅ **Optimized state**: Use proper state management patterns

## 🧪 State Management

### Approved Patterns
- ✅ **Provider**: For simple state
- ✅ **BLoC/Cubit**: For complex business logic
- ✅ **Riverpod**: As alternative to Provider

### Implementation Rules
- ✅ **Reactive patterns**: If A changes, B should automatically respond
- ✅ **Stateless widgets**: Prefer with external state
- ✅ **Immutable state**: Follow immutability principles

## 📦 Dependencies (APPROVED ONLY)

### Core Packages
- ✅ `flutter_localizations` (i18n)
- ✅ `intl` (date/number formatting)
- ✅ `google_fonts` (typography)
- ✅ `provider`/`flutter_bloc`/`riverpod` (state management)
- ✅ `shared_preferences` (local storage)

### Package Guidelines
- ✅ **Evaluate**: maintenance, popularity, compatibility
- ✅ **Null safety**: Required
- ✅ **Team approval**: Document choices

## ✅ Review Checklist (MANDATORY BEFORE ANY COMMIT)

**Code MUST be rejected if it contains:**
- ❌ ANY hardcoded strings in UI (Text, AppBar, SnackBar, etc.)
- ❌ Hardcoded colors (`Color(0xFF...)`, `Colors.red`)
- ❌ Hardcoded spacing (`EdgeInsets.all(16)`, `SizedBox(height: 20)`)
- ❌ Non-theme text styles (`TextStyle(fontSize: 16)`)
- ❌ Missing RTL support (`EdgeInsets` instead of `EdgeInsetsDirectional`)
- ❌ Non-approved button types (`ElevatedButton`, `TextButton`)
- ❌ String interpolation in UI (`'Count: $count'`)
- ❌ String concatenation in UI (`'Hello ' + name`)

**Code MUST pass:**
- ✅ Zero hardcoded strings (use l10n)
- ✅ Only theme colors and spacing
- ✅ FilledButton/OutlinedButton only
- ✅ Full-width buttons with 4px radius
- ✅ EdgeInsetsDirectional usage
- ✅ Proper const usage
- ✅ Performance optimizations
- ✅ RTL layout testing

## 🚨 ENFORCEMENT PROTOCOL

### For Every Code Change:
1. **Before writing**: Verify strings exist in `.arb` files
2. **While coding**: Use only approved patterns and components
3. **Before PR**: Run `flutter analyze` and fix ALL issues
4. **Code review**: Reject ANY violation immediately

### Violation Response:
- **Immediate rejection**: Any hardcoded string/color/spacing
- **Mandatory fix**: Before any other work continues
- **Re-review**: Required after corrections

## 💫 Quick Reference

### ✅ CORRECT Patterns:
```dart
// Strings
Text(l10n.welcome)

// Colors
color: theme.colorScheme.primary

// Spacing
padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL)

// Full-width buttons
SizedBox(
  width: double.infinity,
  child: FilledButton(
    onPressed: onPressed,
    child: Text(l10n.buttonText),
  ),
)
```

### ❌ FORBIDDEN Patterns:
```dart
// NEVER do these:
Text('Welcome')                    // Hardcoded string
color: Colors.blue                 // Hardcoded color
padding: EdgeInsets.all(16)        // Hardcoded spacing
ElevatedButton(...)                // Wrong button type
```

---

**Remember: These rules exist to ensure code quality, maintainability, and user experience. Following them strictly is not optional—it's mandatory for project success.**