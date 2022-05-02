import 'package:yuonsoft/src/models/model_board_attachment.dart';
import 'package:yuonsoft/src/models/model_board_list_item.dart';

class ModelBoardPost extends ModelBoardListItem {
  final String content;
  final String? phone;
  final String? email;
  final List<ModelBoardAttachment>? attachments;
  final bool isOwner;

  ModelBoardPost({
    required this.content,
    required this.phone,
    required this.email,
    required this.attachments,
    required this.isOwner,
    required int id,
    required String subject,
    required String name,
    required String createdAt,
    required String updatedAt,
    required bool private,
  }) : super(
    id: id,
          subject: subject,
          name: name,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
          private: private,
        );

  ModelBoardPost.fromJson(Map<String, Object?> json)
      : this(
    id: json['id'] as int,
          content: json['content'] as String,
          phone: json['phone'] as String?,
          email: json['email'] as String?,
          attachments: (json['attachment'] as List?)
              ?.map((e) => ModelBoardAttachment.fromJson(e))
              .toList(),
          isOwner: json['isOwner'] as bool,
          subject: json['subject'] as String,
          name: json['name'] as String,
          createdAt: json['createdAt'] as String,
          updatedAt: json['updatedAt'] as String,
          private: json['private'] as bool,
        );
}
