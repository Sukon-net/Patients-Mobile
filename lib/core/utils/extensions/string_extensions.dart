extension StringExtensions on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";

  String capitalizeFirstOfEachWord() =>
      split(' ').map((e) => e.capitalize()).join(' ');

  String toCamelCase() => split(' ').map((e) => e.capitalize()).join('');

  String toSnakeCase() => split(' ').map((e) => e.toLowerCase()).join('_');

  String removeLastCharacter() => substring(0, length - 1);

  String removeFirstCharacter() => substring(1);
}
