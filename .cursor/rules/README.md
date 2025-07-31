# Sikila Flutter Documentation

This directory contains all the essential documentation for the Sikila Flutter application development. These documents define strict standards that must be followed by all developers working on the project.

## 🚨 MANDATORY RULE - READ BEFORE ANY CODE DEVELOPMENT 🚨

### **ABSOLUTE REQUIREMENT: Before writing ANY code, cursor MUST follow these three documents:**

1. **📖 [ARCHITECTURE.md](./ARCHITECTURE.md)** - Code architecture patterns and structure
2. **🎨 [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md)** - Visual design system rules  
3. **🧪 [TESTING.md](./TESTING.md)** - Unit testing standards

### **⚠️ CRITICAL ENFORCEMENT:**
- **NO CODE** can be written without consulting these three documents first
- **ALL DEVELOPMENT** must strictly adhere to the rules defined in these files
- **ZERO EXCEPTIONS** - This is non-negotiable for code quality and consistency
- **CODE REVIEW REJECTION** if these guidelines are not followed

---

## 📚 Documentation Overview

### 🎨 [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md)
**Visual Design System Rules**
- Color palette and theming guidelines
- Typography and spacing standards  
- Assets and iconography management
- Internationalization requirements
- Accessibility compliance

### 🏗️ [ARCHITECTURE.md](./ARCHITECTURE.md)
**Code Architecture Guidelines**
- Provider ChangeNotifier pattern requirements
- Centralized models, services, and providers structure
- UI integration patterns with Provider
- Exception handling standards
- File organization rules

### 🧪 [TESTING.md](./TESTING.md)  
**Business Logic Testing Standards**
- Provider testing requirements (unit + integration)
- Service and model testing guidelines
- Test organization and structure
- Performance and memory testing
- Business logic focus (NO UI testing)

## 🚨 Compliance Requirements

### Zero Tolerance Violations
- ❌ **FORBIDDEN**: Writing code without reading ARCHITECTURE.md, DESIGN_SYSTEM.md, TESTING.md first
- ❌ **FORBIDDEN**: Hardcoded colors, spacing, or typography
- ❌ **FORBIDDEN**: Hardcoded strings (must use localization)
- ❌ **FORBIDDEN**: StatefulWidget for business logic
- ❌ **FORBIDDEN**: Direct API calls in UI widgets
- ❌ **FORBIDDEN**: Models/services/providers outside `core/`
- ❌ **FORBIDDEN**: Missing business logic tests

### Mandatory Standards
- ✅ **REQUIRED**: Read and follow all three documentation files before coding
- ✅ **REQUIRED**: All visual elements from design system
- ✅ **REQUIRED**: Provider ChangeNotifier pattern exclusively
- ✅ **REQUIRED**: Centralized architecture in `core/` directory
- ✅ **REQUIRED**: Comprehensive business logic testing
- ✅ **REQUIRED**: Proper internationalization support
- ✅ **REQUIRED**: Accessibility compliance

## 📋 Pre-Commit Verification

Before any code commit, verify compliance by running:

```bash
# 🚨 STEP 1: MANDATORY - Verify documentation has been read
echo "Have you read ARCHITECTURE.md, DESIGN_SYSTEM.md, and TESTING.md? (y/n)"

# 🚨 STEP 2: Design System Compliance
grep -r "Color(0x" lib/           # Should return ZERO results
grep -r "Colors\." lib/           # Should return ZERO results  
grep -r "Text('.*')" lib/         # Should return ZERO results
grep -r "EdgeInsets\.all([0-9]" lib/  # Should return ZERO results

# 🚨 STEP 3: Architecture Compliance  
find lib/screens -name "*.dart" -path "*/models/*"     # Should be empty
find lib/screens -name "*.dart" -path "*/services/*"   # Should be empty
find lib/screens -name "*.dart" -path "*/providers/*"  # Should be empty

# 🚨 STEP 4: Testing Coverage
flutter test test/core/providers/   # All provider tests must pass
```

## 🎯 Development Workflow

1. **🚨 MANDATORY FIRST STEP**: Read ARCHITECTURE.md, DESIGN_SYSTEM.md, and TESTING.md completely
2. **Follow Architecture**: Implement using Provider pattern with centralized core
3. **Apply Design System**: Use only theme colors, spacing, and typography
4. **Write Tests**: Create comprehensive business logic tests
5. **Verify Compliance**: Run verification commands before commit
6. **Code Review**: Ensure adherence to all standards

### ⚠️ CRITICAL REMINDER:
**NO CODE DEVELOPMENT without first reading and understanding the three mandatory documentation files. This is non-negotiable.**

## 📖 Additional Resources

- **Flutter Provider Documentation**: [pub.dev/packages/provider](https://pub.dev/packages/provider)
- **Material Design 3**: [m3.material.io](https://m3.material.io)
- **Flutter Internationalization**: [flutter.dev/docs/development/accessibility-and-localization/internationalization](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
- **Flutter Testing**: [flutter.dev/docs/testing](https://flutter.dev/docs/testing)

## ⚡ Quick Reference

### Theme Usage
```dart
// Colors
Theme.of(context).colorScheme.primary
theme.colorScheme.surface

// Typography  
theme.textTheme.headlineSmall
theme.textTheme.bodyLarge

// Spacing
EdgeInsets.all(AppSpacing.spaceL)
SizedBox(height: AppSpacing.spaceM)
```

### Provider Pattern
```dart
// Provider Setup
ChangeNotifierProvider(
  create: (_) => FeatureProvider()..loadData(),
  child: FeatureScreen(),
)

// Consumer Usage
Consumer<FeatureProvider>(
  builder: (context, provider, child) {
    if (provider.isLoading) return LoadingWidget();
    if (provider.hasError) return ErrorWidget();
    return DataWidget(provider.data);
  },
)
```

### Localization
```dart
// String Usage
Text(AppLocalizations.of(context)!.welcomeMessage)
AppBar(title: Text(l10n.settings))
```

---

**Following these documentation standards ensures consistent, maintainable, and professional Flutter application development.**