# 🚨 STRICT ENFORCEMENT RULES - ZERO TOLERANCE POLICY 🚨

## ⛔ INSTANT CODE REJECTION CRITERIA

### 🌐 INTERNATIONALIZATION - ABSOLUTE ZERO TOLERANCE

**ANY CODE CONTAINING THE FOLLOWING WILL BE IMMEDIATELY REJECTED:**

#### Hardcoded Strings (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - Hardcoded UI strings
Text('Welcome')
Text("Dashboard")
Text('Statistics Overview')
Text('Total Users')
Text('Create Post')
Text('Settings')
AppBar(title: Text('Dashboard'))
SnackBar(content: Text('Success'))
```

#### String Interpolation in UI (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - String interpolation in UI
Text('Count: $count')
Text("Welcome $userName")
Text('${items.length} items')
```

#### Concatenated Strings in UI (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - String concatenation in UI
Text('Hello ' + name)
Text(greeting + ' ' + userName)
```

#### Hardcoded Error/Success Messages (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - Hardcoded messages
throw Exception('Something went wrong')
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Success'))
)
```

### ✅ MANDATORY REPLACEMENT PATTERNS

**EVERY UI STRING MUST USE:**
```dart
// ✅ REQUIRED - Localized strings only
Text(l10n.welcome)
Text(l10n.dashboard)
Text(l10n.statisticsOverview)
Text(l10n.totalUsers)
AppBar(title: Text(l10n.dashboard))
SnackBar(content: Text(l10n.success))
```

### 🔍 PRE-COMMIT VALIDATION CHECKLIST

**BEFORE ANY CODE IS ACCEPTED:**

1. ✅ **Grep Search**: `grep -r "Text('.*')" lib/` must return ZERO results
2. ✅ **Grep Search**: `grep -r 'Text(".*")' lib/` must return ZERO results  
3. ✅ **Manual Review**: Every Text(), AppBar(), SnackBar(), etc. uses l10n
4. ✅ **Localization Files**: All strings exist in `app_en.arb` AND `app_ar.arb`
5. ✅ **No Exceptions**: Debug prints, comments, and internal logs can have hardcoded strings - UI CANNOT

### 🎨 DESIGN SYSTEM - ABSOLUTE ZERO TOLERANCE

#### Hardcoded Colors (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - Hardcoded colors
color: Colors.red
color: Color(0xFF123456)
backgroundColor: Colors.blue
Container(color: Colors.white)
```

#### Hardcoded Spacing (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - Hardcoded spacing
EdgeInsets.all(16)
EdgeInsets.symmetric(horizontal: 20)
SizedBox(height: 24)
Padding(padding: EdgeInsets.only(top: 8))
```

#### Hardcoded Text Styles (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - Hardcoded text styles
TextStyle(fontSize: 16)
TextStyle(fontWeight: FontWeight.bold)
style: TextStyle(color: Colors.black)
```

#### Wrong Button Types (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - Wrong button types
ElevatedButton(...)
TextButton(...)
RaisedButton(...)
FlatButton(...)
```

### ✅ MANDATORY DESIGN SYSTEM PATTERNS

```dart
// ✅ REQUIRED - Theme colors only
color: theme.colorScheme.primary
backgroundColor: theme.colorScheme.surface

// ✅ REQUIRED - AppSpacing constants only
padding: EdgeInsetsDirectional.all(AppSpacing.spaceL)
SizedBox(height: AppSpacing.spaceXL)

// ✅ REQUIRED - Theme text styles only
style: theme.textTheme.headlineMedium
style: theme.textTheme.bodyLarge

// ✅ REQUIRED - Only approved button types
FilledButton(...)
OutlinedButton(...)
```

### 🛡️ RTL SUPPORT - ABSOLUTE ZERO TOLERANCE

#### Wrong Padding/Margin (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - Non-RTL padding
EdgeInsets.all(16)
EdgeInsets.only(left: 8, right: 16)
Padding(padding: EdgeInsets.symmetric(horizontal: 20))
```

#### Wrong Positioning (FORBIDDEN)
```dart
// ❌ INSTANT REJECTION - Non-RTL positioning
Positioned(left: 10, child: ...)
Align(alignment: Alignment.centerLeft)
```

### ✅ MANDATORY RTL PATTERNS

```dart
// ✅ REQUIRED - RTL-aware padding
EdgeInsetsDirectional.all(AppSpacing.spaceL)
EdgeInsetsDirectional.only(start: AppSpacing.spaceS)

// ✅ REQUIRED - RTL-aware positioning
Positioned.directional(start: 10, child: ...)
Align(alignment: AlignmentDirectional.centerStart)
```

## 🚦 ENFORCEMENT PROTOCOL

### 1. AUTOMATED CHECKS (MANDATORY)
- **Pre-commit hook**: Scan for hardcoded strings
- **CI/CD pipeline**: Reject builds with violations
- **Linting rules**: Custom rules for string detection

### 2. MANUAL REVIEW (REQUIRED)
- **Every PR**: Manual verification of l10n usage
- **Code reviewer**: Must verify ZERO hardcoded strings
- **Design review**: Must verify theme compliance

### 3. VIOLATION RESPONSE
- **Immediate rejection**: Any hardcoded string in UI
- **No exceptions**: No "temporary" hardcoded strings allowed
- **Mandatory fix**: All violations fixed before merge

## 📋 VIOLATION DETECTION COMMANDS

### Search for Hardcoded Strings
```bash
# Find hardcoded strings in Text widgets
grep -r "Text('.*')" lib/
grep -r 'Text(".*")' lib/

# Find hardcoded strings in AppBar
grep -r "title: Text('.*')" lib/
grep -r 'title: Text(".*")' lib/

# Find hardcoded colors
grep -r "Color(0x" lib/
grep -r "Colors\." lib/

# Find hardcoded spacing
grep -r "EdgeInsets\." lib/
grep -r "SizedBox(" lib/
```

### Required Results
**ALL COMMANDS ABOVE MUST RETURN ZERO RESULTS FOR UI CODE**

## 🎯 SUCCESS CRITERIA

**Code is ONLY acceptable when:**
1. ✅ Zero hardcoded strings in UI
2. ✅ All strings in l10n files (both en & ar)
3. ✅ Zero hardcoded colors
4. ✅ Zero hardcoded spacing
5. ✅ Zero hardcoded text styles
6. ✅ Only approved button types
7. ✅ Full RTL support
8. ✅ Passes all automated checks

## 🔥 REMEMBER: NO EXCEPTIONS, NO COMPROMISES, NO TEMPORARY FIXES

**This is not negotiable. Quality and internationalization are non-optional.**