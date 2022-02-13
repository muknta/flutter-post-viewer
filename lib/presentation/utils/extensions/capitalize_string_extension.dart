extension CapitalizeStringExtension on String {
  // ignore: unnecessary_this
  String capitalize() => '${this[0].toUpperCase()}${this.substring(1)}';
}
