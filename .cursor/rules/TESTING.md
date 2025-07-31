# Sikila Flutter Testing Guidelines

This document defines the **MANDATORY UNIT TESTING STANDARDS** for business logic in the Sikila Flutter application. These guidelines focus exclusively on unit testing business logic components.

## 🚨 ABSOLUTE TESTING REQUIREMENTS 🚨

- **Business Logic ONLY**: Test providers, services, models, and utilities
- **NO UI Testing**: Widget tests forbidden unless explicitly requested
- **100% Provider Coverage**: Every provider must have comprehensive unit tests
- **Unit Tests ONLY**: Focus on isolated business logic testing
- **Performance Aware**: Test concurrent operations and memory management

---

## 1. Test Organization Rules

### 🚨 MANDATORY TEST STRUCTURE 🚨

**Test directory MUST mirror core architecture:**

#### Required Test Directories:
- `test/core/models/` - ALL model unit tests (MANDATORY)
- `test/core/services/` - ALL service unit tests (MANDATORY)  
- `test/core/providers/` - ALL provider unit tests (MANDATORY)
- `test/core/exceptions/` - Exception class tests
- `test/core/utils/` - Utility function tests
- `test/test_utils/` - Shared test data and helpers

#### Test File Naming:
- Provider tests: `{provider_name}_test.dart`
- Service tests: `{service_name}_test.dart`
- Model tests: `{model_name}_test.dart`
- One test file per business logic file (1:1 mapping)

#### Test Data Management:
- Centralized test constants in `test/test_utils/test_data.dart`
- Mock services in `test/test_utils/mock_services.dart` (when needed)
- Helper functions in `test/test_utils/test_helpers.dart`

---

## 2. Provider Testing Rules (MANDATORY)

### 🚨 COMPREHENSIVE PROVIDER UNIT TEST REQUIREMENTS 🚨

**EVERY provider MUST have complete unit test coverage:**

#### Provider Test Requirements:
- **Initial State Testing**: Verify all getter initial values are correct
- **Loading State Management**: Test loading indicators and state transitions
- **Error Handling**: Test all error scenarios and recovery mechanisms
- **State Calculations**: Verify isEmpty, hasData, hasError, itemCount logic
- **Notification System**: Test ChangeNotifier listener notifications
- **Concurrent Operations**: Test multiple simultaneous operations safety
- **Resource Cleanup**: Test proper disposal and memory management
- **Business Logic Methods**: Test all public methods comprehensively

#### Test Organization Structure:
- **Initial State Group**: All initial value tests
- **Business Logic Operations Group**: Method functionality tests
- **State Notifications Group**: ChangeNotifier behavior tests
- **Error Handling Group**: Error scenarios and recovery tests
- **Resource Management Group**: Disposal and cleanup tests
- **Concurrent Operations Group**: Thread safety and race condition tests

#### Required Test Scenarios:
- All provider getters return expected initial values
- Loading states transition correctly during operations
- Error states are set and cleared appropriately
- Listeners are notified on state changes
- Concurrent operations don't corrupt state
- Provider disposes without throwing exceptions
- All error paths are covered and handled gracefully

---

## 3. Service Testing Rules

### 🚨 SERVICE UNIT TEST REQUIREMENTS 🚨

**ALL services MUST have comprehensive unit test coverage:**

#### Service Test Requirements:
- **HTTP Operations**: Test all CRUD operations (GET, POST, PUT, DELETE)
- **Error Handling**: Network errors, timeouts, invalid responses
- **Data Parsing**: JSON serialization and deserialization accuracy
- **Status Codes**: All HTTP status code scenarios (200, 400, 401, 404, 500)
- **Exception Mapping**: Custom exception creation and error messaging
- **Input Validation**: Parameter validation and edge cases
- **Response Handling**: Success and failure response processing

#### Test Organization Structure:
- **API Operations Group**: All HTTP method tests
- **Error Handling Group**: Network and API error scenarios
- **Data Processing Group**: JSON parsing and model creation tests
- **Validation Group**: Input parameter validation tests
- **Exception Group**: Custom exception creation tests

#### Required Test Scenarios:
- All service methods handle successful responses correctly
- Network failures throw appropriate custom exceptions
- Invalid JSON responses are handled gracefully
- HTTP error status codes map to correct exception types
- Input parameters are validated before API calls
- Timeout scenarios are handled properly
- Service methods work with mocked HTTP responses when needed

---

## 4. Model Testing Rules

### 🚨 MODEL UNIT TEST REQUIREMENTS 🚨

**ALL models MUST have comprehensive unit test coverage:**

#### Model Test Requirements:
- **JSON Serialization**: fromJson and toJson methods accuracy
- **Equality Testing**: == operator and hashCode consistency
- **Copy Operations**: copyWith method functionality with null handling
- **Immutability**: Ensure fields cannot be modified after creation
- **Edge Cases**: Null handling, invalid data, boundary conditions
- **Field Validation**: All required and optional field handling
- **Type Safety**: Correct data type enforcement

#### Test Organization Structure:
- **JSON Serialization Group**: fromJson and toJson tests
- **Equality Group**: == operator and hashCode tests
- **Copy Operations Group**: copyWith method tests
- **Validation Group**: Field validation and edge case tests
- **Immutability Group**: Object immutability verification tests

#### Required Test Scenarios:
- Model serializes to JSON with all fields correctly mapped
- Model deserializes from JSON creating equivalent objects
- Models with identical field values are equal and have same hashCode
- Models with different field values are not equal
- copyWith creates new instances with updated fields
- copyWith preserves unchanged fields from original model
- Invalid JSON data throws appropriate exceptions
- Null fields are handled according to model design
- All model fields maintain immutability after creation

---

## 5. Test Data Management Rules

### 🚨 SHARED TEST DATA REQUIREMENTS 🚨

**Centralized test data for consistency and maintainability:**

#### Test Data Organization:
- **Single Source**: All test constants in `test/test_utils/test_data.dart`
- **Model Samples**: Predefined model instances for testing
- **Collections**: Empty and populated lists for different scenarios
- **JSON Data**: Valid and invalid JSON examples for parsing tests
- **Error Messages**: Standardized error messages for exception testing
- **Edge Cases**: Boundary condition data (null, empty, maximum values)

#### Test Data Categories:
- **Sample Models**: Representative model instances with realistic data
- **Sample Collections**: Lists and maps for testing collection operations
- **JSON Samples**: Valid JSON for serialization/deserialization tests
- **Invalid Data**: Malformed JSON and edge cases for error testing
- **Error Constants**: Standard error messages and exception data
- **Boundary Values**: Min/max values for validation testing

#### Test Data Rules:
- NO hardcoded test data in individual test files
- All test constants MUST be centralized in TestData class
- Use descriptive names for test data constants
- Provide both valid and invalid data samples
- Include edge cases and boundary conditions
- Maintain consistency across all test files
- Update test data when model structures change

---

## 6. Test Execution Rules

### 🚨 TEST EXECUTION REQUIREMENTS 🚨

#### Test Execution Commands:
- **Individual Tests**: `flutter test test/core/providers/{provider}_test.dart`
- **Category Tests**: `flutter test test/core/providers/` or `test/core/services/`
- **All Unit Tests**: `flutter test`
- **Coverage Generation**: `flutter test --coverage` for business logic coverage

#### Test Performance Standards:
- **Unit Tests**: MUST complete in under 10 seconds per file
- **Test Suites**: Complete test suite under 2 minutes
- **Memory Usage**: Monitor and prevent memory leaks during testing
- **Concurrent Safety**: All tests must be thread-safe and race-condition free

#### Test Environment Rules:
- **Isolation**: Each test MUST be completely independent
- **Clean State**: Tests cannot depend on execution order
- **Setup/Teardown**: Proper resource initialization and cleanup
- **Deterministic**: Tests must produce consistent results
- **No External Dependencies**: Unit tests cannot rely on network or external services

---

## 7. Testing Best Practices Rules

### 🚨 MANDATORY TESTING PRACTICES 🚨

#### Test Writing Standards:
- **Descriptive Names**: Test names MUST clearly describe what is being tested
- **AAA Pattern**: Arrange, Act, Assert structure is MANDATORY
- **Single Responsibility**: One logical assertion per test method
- **Error Scenarios**: MUST test both success and failure paths
- **Edge Cases**: MUST test boundary conditions, null values, and limits
- **Readable Tests**: Tests should be self-documenting code

#### Test Organization Standards:
- **Logical Grouping**: Use `group()` blocks to organize related test cases
- **Setup/Teardown**: MANDATORY proper resource initialization and cleanup
- **Shared Constants**: Use centralized test data for consistency
- **Test Documentation**: Comment complex business logic test scenarios
- **Consistent Structure**: Follow same organization pattern across all test files

#### Error Handling Standards:
- **Expected Failures**: Handle known failure scenarios gracefully
- **Exception Testing**: Verify correct exception types are thrown
- **Timeout Handling**: Set appropriate timeouts for async operations
- **Resource Cleanup**: MANDATORY disposal in tearDown methods
- **Memory Management**: Verify no memory leaks in provider disposal

---

## 8. UNIT TESTING REQUIREMENTS CHECKLIST

### 🚨 ZERO TOLERANCE VIOLATIONS 🚨

- ❌ **FORBIDDEN**: Widget/UI tests unless explicitly requested
- ❌ **FORBIDDEN**: Provider tests without comprehensive coverage
- ❌ **FORBIDDEN**: Tests without proper tearDown/disposal
- ❌ **FORBIDDEN**: Hardcoded test data scattered in multiple files
- ❌ **FORBIDDEN**: Missing model serialization tests
- ❌ **FORBIDDEN**: Service tests without error handling verification
- ❌ **FORBIDDEN**: Tests that depend on external network services
- ❌ **FORBIDDEN**: Tests that rely on execution order
- ❌ **FORBIDDEN**: Missing resource cleanup in test tearDown

### ✅ MANDATORY REQUIREMENTS

- ✅ **REQUIRED**: 100% provider unit test coverage
- ✅ **REQUIRED**: All service method unit testing with error scenarios
- ✅ **REQUIRED**: Complete model testing (JSON, equality, copyWith)
- ✅ **REQUIRED**: Proper test organization mirroring code structure
- ✅ **REQUIRED**: Shared test data in `test_utils/test_data.dart`
- ✅ **REQUIRED**: Unit testing for concurrent operations
- ✅ **REQUIRED**: Memory management verification in unit tests
- ✅ **REQUIRED**: Timeout handling in all async tests
- ✅ **REQUIRED**: Resource disposal verification in tearDown
- ✅ **REQUIRED**: Error path coverage for all business logic methods

### 📋 UNIT TESTING COMPLIANCE VERIFICATION

Before code review, verify:

1. **Provider Coverage**: Every provider has comprehensive unit tests
2. **Service Testing**: All service methods tested with error scenarios
3. **Model Testing**: JSON serialization, equality, and copy operations tested
4. **Error Handling**: All error paths covered in unit tests
5. **Performance**: Concurrent operations tested for thread safety
6. **Resource Management**: Proper setup, tearDown, and disposal
7. **Test Data**: Centralized test constants used consistently
8. **Test Independence**: All tests run successfully in isolation
9. **Memory Safety**: No memory leaks in provider disposal tests

---

**These unit testing guidelines ensure robust, reliable business logic with comprehensive test coverage focused exclusively on providers, services, and models without UI dependencies.**