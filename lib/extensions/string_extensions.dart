extension StringExtensions on String {
  double parseDouble() {
    if (isEmpty) return 0.0;
    final value = replaceAll('.', '').replaceAll(',', '.');
    return double.parse(value);
  }
}
