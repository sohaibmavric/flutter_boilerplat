/// Onboarding carousel item data model
/// Contains content for each carousel slide
class OnboardingCarouselItem {
  /// Subtitle/section header for the carousel item
  final String subtitle;
  
  /// Detailed description text for the carousel item
  final String description;

  /// Creates a new OnboardingCarouselItem instance
  const OnboardingCarouselItem({
    required this.subtitle,
    required this.description,
  });

  /// Creates a OnboardingCarouselItem from JSON data
  factory OnboardingCarouselItem.fromJson(Map<String, dynamic> json) {
    return OnboardingCarouselItem(
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
    );
  }

  /// Converts OnboardingCarouselItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'subtitle': subtitle,
      'description': description,
    };
  }

  /// Creates a copy of this OnboardingCarouselItem with updated fields
  OnboardingCarouselItem copyWith({
    String? subtitle,
    String? description,
  }) {
    return OnboardingCarouselItem(
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OnboardingCarouselItem &&
        other.subtitle == subtitle &&
        other.description == description;
  }

  @override
  int get hashCode {
    return Object.hash(subtitle, description);
  }

  @override
  String toString() {
    return 'OnboardingCarouselItem(subtitle: $subtitle, description: $description)';
  }
}