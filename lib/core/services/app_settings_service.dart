import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing app settings like theme and language
/// Provides state management and persistence for user preferences
class AppSettingsService extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language_code';
  
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');
  
  SharedPreferences? _prefs;
  
  /// Current theme mode
  ThemeMode get themeMode => _themeMode;
  
  /// Current locale
  Locale get locale => _locale;
  
  /// Initialize the service and load saved preferences
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadSettings();
  }
  
  /// Load settings from shared preferences
  Future<void> _loadSettings() async {
    final themeIndex = _prefs?.getInt(_themeKey) ?? 0;
    _themeMode = ThemeMode.values[themeIndex];
    
    final languageCode = _prefs?.getString(_languageKey) ?? 'en';
    _locale = Locale(languageCode);
    
    notifyListeners();
  }
  
  /// Update theme mode
  Future<void> setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await _prefs?.setInt(_themeKey, themeMode.index);
    notifyListeners();
  }
  
  /// Update locale
  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _prefs?.setString(_languageKey, locale.languageCode);
    notifyListeners();
  }
}