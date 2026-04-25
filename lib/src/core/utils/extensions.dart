extension StringExtension on String {
  String capitalize() {
    if (toUpperCase() == this) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
