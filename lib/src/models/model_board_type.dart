enum BoardAuth { guest, user }

class ModelBoardType {
  final int id;
  final String name;
  final String nameKr;
  final String description;
  final BoardAuth authentication;
  final int attachmentSize;

  ModelBoardType(
    this.id,
    this.name,
    this.nameKr,
    this.description,
    this.authentication,
    this.attachmentSize,
  );

  ModelBoardType.fromJson(Map<String, Object?> json)
      : this(
    json['id'] as int,
          json['name'] as String,
          json['nameKr'] as String,
          json['description'] as String,
          BoardAuth.values
              .singleWhere((e) => e.name == json['authentication'] as String),
          json['attachmentSize'] as int,
        );
}
