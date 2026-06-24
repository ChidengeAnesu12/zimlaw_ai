/// Centralized border radius values.
/// Card radius = 24px per design spec; smaller elements scale down from there.
class AppRadius {
  AppRadius._();

  static const double card = 24.0;       // GlassCard, FeatureCard, LawyerCard
  static const double button = 16.0;     // CustomButton
  static const double input = 14.0;      // CustomTextField, SearchBar
  static const double chip = 50.0;       // Filter chips (pill-shaped)
  static const double sheet = 28.0;      // Bottom sheets / modals
  static const double avatar = 100.0;    // Fully circular
  static const double badge = 8.0;       // Small status badges
}