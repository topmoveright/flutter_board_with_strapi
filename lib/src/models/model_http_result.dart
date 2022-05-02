class ModelHttpResult {
  final int statusCode;
  final Map<String, Object?>? value;

  ModelHttpResult(this.statusCode, this.value);
}