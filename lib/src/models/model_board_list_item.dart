class ModelBoardListItem {
  final int id;
  final String subject;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool private;

  ModelBoardListItem({
    required this.id,
    required this.subject,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.private,
  });

  ModelBoardListItem.fromJson(Map<String, Object?> data)
      : this(
          id: data['id'] as int,
          subject: data['subject'] as String,
          name: data['name'] as String,
          createdAt: DateTime.parse(data['createdAt'] as String),
          updatedAt: DateTime.parse(data['updatedAt'] as String),
          private: data['private'] as bool,
        );
}
