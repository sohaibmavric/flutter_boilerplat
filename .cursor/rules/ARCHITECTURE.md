# Sikila Flutter Architecture Guidelines

This document defines the **MANDATORY ARCHITECTURAL PATTERNS** for the Sikila Flutter application. These guidelines must be strictly followed for consistency, maintainability, and scalability.

## 🚨 ABSOLUTE ARCHITECTURAL REQUIREMENTS 🚨

- **Provider ChangeNotifier Pattern**: ONLY state management pattern allowed
- **Centralized Models & Services**: All models and services in `core/`
- **Zero StatefulWidget**: All state management through Provider
- **Business Logic Separation**: Complete separation of UI and business logic

---

## 1. Project Architecture Structure

### 🚨 MANDATORY FILE ORGANIZATION 🚨

```
lib/
├── app/
│   ├── app.dart                    # Main application widget
│   ├── router/                     # Navigation and routing
│   ├── theme/                      # Theme definitions
│   └── l10n/                       # Localization files
│
├── core/
│   ├── constants/                  # App-wide constants
│   ├── models/                     # 🚨 ALL data models (centralized)
│   ├── services/                   # 🚨 ALL API services (centralized)
│   ├── providers/                  # 🚨 ALL state providers (centralized)
│   ├── exceptions/                 # Custom exception classes
│   ├── utils/                      # Utility functions
│   └── widgets/                    # Shared, reusable widgets
│
├── screens/
│   └── screen_name/
│       ├── widgets/                # Screen-specific widgets ONLY
│       └── screen_name_screen.dart # Main screen file
│
└── main.dart                       # App entry point
```

---

## 2. Provider ChangeNotifier Pattern

### 🚨 MANDATORY PROVIDER ARCHITECTURE 🚨

**ALL state management MUST use Provider ChangeNotifier pattern:**

#### Provider Class Requirements:
- **Location**: All providers in `lib/core/providers/`
- **Inheritance**: Must extend `ChangeNotifier`
- **State Variables**: All private with underscore prefix
- **Public Interface**: Only expose getters and methods, never direct state
- **Error Handling**: Every async operation wrapped in try-catch
- **Loading States**: Mandatory loading indicators for all async operations
- **Immutable Data**: Use `List.unmodifiable()` for exposed collections
- **Disposal**: Proper resource cleanup in `dispose()` method

#### Provider Structure:
- **Private State**: `_data`, `_isLoading`, `_error`, `_isInitialized`
- **Public Getters**: `data`, `isLoading`, `error`, `isEmpty`, `hasData`, `hasError`, `isInitialized`, `itemCount`
- **Public Methods**: `loadData()`, `refreshData()`, `addItem()`, `updateItem()`, `deleteItem()`, `clearError()`
- **Private Helpers**: `_executeWithLoading()`, `_setLoading()`, `_clearError()`, `_setError()`

#### Notification Rules:
- **Call `notifyListeners()`** after every state change
- **Check for changes** before notifying (avoid unnecessary rebuilds)
- **Use helper methods** to encapsulate notification logic

---

## 3. Centralized Models

### 🚨 MANDATORY MODEL STRUCTURE 🚨

**ALL data models MUST be in `lib/core/models/`:**

#### Model Class Requirements:
- **Location**: All models in `lib/core/models/`
- **Immutability**: All fields must be `final`
- **Constructor**: Use `const` constructor when possible
- **JSON Support**: Must have `fromJson()` factory and `toJson()` method
- **Equality**: Override `==` operator and `hashCode`
- **Copy Method**: Implement `copyWith()` for immutable updates
- **String Representation**: Override `toString()` for debugging

#### Model Structure Standards:
- **Fields**: All required fields, optional fields with nullable types
- **Validation**: Type-safe JSON parsing with proper casting
- **Null Safety**: Explicit null handling for optional fields
- **Documentation**: JSDoc comments for complex models
- **Naming**: Clear, descriptive field names following camelCase

#### Forbidden Practices:
- ❌ Models in screen folders (`lib/screens/*/models/`)
- ❌ Mutable fields (non-final)
- ❌ Direct Map usage in UI without models
- ❌ Missing JSON serialization methods
- ❌ Missing equality implementations

---

## 4. Centralized Services

### 🚨 MANDATORY SERVICE STRUCTURE 🚨

**ALL API services MUST be in `lib/core/services/`:**

#### Service Class Requirements:
- **Location**: All services in `lib/core/services/`
- **Static Methods**: No instantiation, use static methods only
- **Private Constructor**: Prevent instantiation with private constructor
- **Error Handling**: Comprehensive exception handling for all scenarios
- **Timeout**: Mandatory 10-second timeout for all requests
- **Type Safety**: Proper type casting and null safety
- **Constants**: Use constants for base URLs and timeouts

#### Service Structure Standards:
- **HTTP Operations**: GET, POST, PUT, DELETE with proper headers
- **JSON Handling**: Proper encoding/decoding with type safety
- **Exception Types**: Handle TimeoutException, SocketException, FormatException
- **Status Codes**: Explicit handling of HTTP status codes
- **Response Validation**: Validate response structure before parsing
- **Resource Cleanup**: Proper disposal of HTTP connections

#### Error Handling Requirements:
- **Custom Exceptions**: Use `ApiException` for all API errors
- **Network Errors**: Handle connectivity issues gracefully
- **Timeout Handling**: Clear timeout messages for users
- **Status Code Mapping**: Map HTTP status codes to meaningful errors
- **Logging**: Log errors for debugging without exposing sensitive data

#### Forbidden Practices:
- ❌ Services in screen folders (`lib/screens/*/services/`)
- ❌ Direct HTTP calls in UI widgets
- ❌ Hardcoded URLs or configuration
- ❌ Missing timeout handling
- ❌ Raw exception throwing without custom types

---

## 5. UI Integration with Provider

### 🚨 MANDATORY UI PATTERN 🚨

**ALL screens MUST use Provider integration pattern:**

#### Screen Structure Requirements:
- **Widget Type**: Use `StatelessWidget` only for screens
- **Provider Setup**: Wrap with `ChangeNotifierProvider` at screen level
- **Consumer Usage**: Use `Consumer<Provider>` for reactive UI parts
- **State Handling**: Handle all provider states (loading, error, empty, success)
- **Localization**: All text from `AppLocalizations`
- **Theme Access**: Use `Theme.of(context)` for styling

#### Provider Integration Pattern:
- **Provider Creation**: `ChangeNotifierProvider(create: (_) => Provider()..loadData())`
- **Consumer Widgets**: Wrap reactive UI with `Consumer<Provider>`
- **State Branching**: Explicit handling of all provider states
- **Loading States**: Show indicators during async operations
- **Error States**: Display error UI with retry functionality
- **Empty States**: Handle no-data scenarios gracefully
- **Success States**: Display data with refresh capability

#### UI State Management:
- **Loading**: Show progress indicators and disable interactions
- **Error**: Display error message with retry button
- **Empty**: Show appropriate empty state message
- **Success**: Display data with pull-to-refresh
- **Optimistic Updates**: Update UI before API confirmation where appropriate

#### Forbidden Practices:
- ❌ StatefulWidget for business logic
- ❌ setState() in Provider context
- ❌ Direct API calls in widgets
- ❌ Hardcoded strings in UI
- ❌ Missing state handling

---

## 6. Business Logic Testing

### 🚨 MANDATORY TESTING REQUIREMENTS 🚨

**For detailed testing guidelines, see `TESTING.md`**

#### Core Testing Principles:
- **Test Business Logic ONLY**: Focus on providers, services, and models
- **NO UI Testing**: Widget tests are not required unless specifically requested
- **100% Provider Coverage**: Every provider must have comprehensive tests
- **Integration Tests**: Real API calls with proper error handling
- **State Verification**: Test all provider states and transitions

#### Required Test Types:
- **Unit Tests**: Provider state management, error handling, data transformations
- **Integration Tests**: Real API calls, network scenarios, performance
- **Model Tests**: JSON serialization, equality, copyWith methods
- **Service Tests**: API error handling, timeout scenarios, data parsing

#### Test Organization:
- **Location**: Mirror production structure in `test/` directory
- **Naming**: `*_test.dart` for unit tests, `*_integration_test.dart` for integration
- **Grouping**: Logical test groups with descriptive names
- **Setup/Teardown**: Proper resource management and cleanup

---

## 7. Exception Handling

### 🚨 MANDATORY EXCEPTION STRUCTURE 🚨

**ALL custom exceptions MUST be in `lib/core/exceptions/`:**

#### Exception Class Requirements:
- **Location**: All exceptions in `lib/core/exceptions/`
- **Implementation**: Implement `Exception` interface
- **Immutability**: All fields must be `final`
- **Constructor**: Use `const` constructor
- **String Representation**: Override `toString()` for debugging
- **Specificity**: Create specific exception types for different error categories

#### Required Exception Types:
- **ApiException**: For all API-related errors with optional status code
- **ValidationException**: For data validation errors with optional field reference
- **AuthException**: For authentication and authorization errors
- **NetworkException**: For network connectivity issues
- **CacheException**: For local storage and caching errors

#### Exception Handling Rules:
- **Catch Specific Types**: Handle specific exceptions, not generic `Exception`
- **Error Context**: Provide meaningful error messages for users
- **Logging**: Log technical details without exposing sensitive information
- **Localization**: Error messages shown to users must be localized
- **Recovery**: Provide recovery options where possible

---

## 8. Provider Registration

### 🚨 MANDATORY PROVIDER SETUP 🚨

**Provider registration requirements:**

#### Global Providers:
- **Location**: Register in `lib/app/app.dart`
- **Setup**: Use `MultiProvider` for multiple providers
- **Lifecycle**: Create providers at app startup
- **Scope**: Only truly global state should be registered globally
- **Dependencies**: Handle provider dependencies correctly

#### Local Providers:
- **Screen-Level**: Use `ChangeNotifierProvider` at screen level for screen-specific state
- **Disposal**: Ensure proper disposal when screen is destroyed
- **Initialization**: Initialize with data loading if needed
- **Isolation**: Keep screen state isolated from global state

#### Provider Hierarchy:
- **Global**: Authentication, user session, app settings
- **Feature**: Screen-specific business logic and state
- **Widget**: Component-specific state (rare, prefer stateless widgets)

---

## 9. ABSOLUTE REQUIREMENTS CHECKLIST

### 🚨 ZERO TOLERANCE VIOLATIONS 🚨

- ❌ **FORBIDDEN**: StatefulWidget for business logic
- ❌ **FORBIDDEN**: Direct API calls in UI widgets  
- ❌ **FORBIDDEN**: Models in screen folders
- ❌ **FORBIDDEN**: Services in screen folders
- ❌ **FORBIDDEN**: Providers in screen folders
- ❌ **FORBIDDEN**: setState() for business state
- ❌ **FORBIDDEN**: Raw Map usage in UI
- ❌ **FORBIDDEN**: Hardcoded API URLs or error messages
- ❌ **FORBIDDEN**: Missing error handling in async operations
- ❌ **FORBIDDEN**: Missing loading states
- ❌ **FORBIDDEN**: Direct state variable exposure

### ✅ MANDATORY REQUIREMENTS

- ✅ **REQUIRED**: All state management through Provider ChangeNotifier
- ✅ **REQUIRED**: All models in `lib/core/models/`
- ✅ **REQUIRED**: All services in `lib/core/services/`
- ✅ **REQUIRED**: All providers in `lib/core/providers/`
- ✅ **REQUIRED**: All exceptions in `lib/core/exceptions/`
- ✅ **REQUIRED**: Comprehensive business logic tests (see `TESTING.md`)
- ✅ **REQUIRED**: Custom exception classes for all error types
- ✅ **REQUIRED**: Loading states for all async operations
- ✅ **REQUIRED**: Proper disposal of providers and resources
- ✅ **REQUIRED**: Immutable data exposure from providers
- ✅ **REQUIRED**: Error handling with user-friendly messages
- ✅ **REQUIRED**: Timeout handling for all network requests

### 📋 ARCHITECTURE COMPLIANCE VERIFICATION

Before any code review or deployment, verify:

1. **File Organization**: All files in correct `core/` locations
2. **Provider Pattern**: No StatefulWidget for business logic
3. **Error Handling**: Custom exceptions and proper error states
4. **Testing**: Comprehensive business logic test coverage
5. **State Management**: Proper Provider usage with immutable exposure
6. **API Integration**: Centralized services with timeout and error handling
7. **Resource Management**: Proper disposal and cleanup

---

**These architectural guidelines ensure maintainable, testable, and scalable Flutter applications with consistent patterns and robust business logic separation.**