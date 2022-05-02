

extension ExtensionString on String {
  String get stripHtmlTags =>
     replaceAll("(?s)<(\\w+)\\b[^<>]*>.*?</\\1>", "");

  int get sanitizePositiveInt {
    var tempInt = int.tryParse(this) ?? 1;
    tempInt = tempInt == 0 ? 1 : tempInt.abs();
    return tempInt;
  }
}