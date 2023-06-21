extension CapitalizeEnum on Enum {
  String captializeValue(dynamic enumValue) {
    final String value = enumValue.toString().split('.').last;
    return value[0].toUpperCase() + value.substring(1);
  }
}
