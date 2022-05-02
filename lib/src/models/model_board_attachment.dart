class ModelBoardAttachment {
  final int id;
  final String url;
  final String name;

  ModelBoardAttachment({
    required this.id,
    required this.url,
    required this.name,
  });

  ModelBoardAttachment.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as int,
          url: json['url'] as String,
          name: json['name'] as String,
        );
}
