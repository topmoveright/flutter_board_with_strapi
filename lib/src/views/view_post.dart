import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuonsoft/src/controllers/controller_post.dart';
import 'package:yuonsoft/src/core/utils/util_datetime.dart';
import 'package:yuonsoft/src/core/utils/util_strapi.dart';
import 'package:yuonsoft/src/models/model_board_post.dart';
import 'package:yuonsoft/src/views/view_layout.dart';

class ViewPost extends GetView<ControllerPost> {
  ViewPost({Key? key}) : super(key: key);

  @override
  final controller = Get.find<ControllerPost>(tag: '_${Get.currentRoute}');

  @override
  Widget build(BuildContext context) {
    return ViewLayout(
      child: controller.obx(
        (status) => buildContent(status!),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Center(child: Text('내용이 없습니다.')),
        onError: (error) => Center(child: Text(error ?? '오류가 발생했습니다.')),
      ),
    );
  }

  Column buildContent(ModelBoardPost post) {
    return Column(
      children: [
        ButtonBar(
          children: [
            IconButton(
              onPressed: () => controller.goPostUpdate(),
              icon: const Icon(Icons.create),
            ),
            IconButton(
              onPressed: () => controller.actPostDelete(),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        buildListTile(
          title: const Text('날짜'),
          child: Text(UtilDataTime.strRegDT(post.createdAt)),
        ),
        buildListTile(
          title: const Text('제목'),
          child: Text(post.subject),
        ),
        buildListTile(
          title: const Text('이름'),
          child: Text(post.name),
        ),
        buildListTile(
          title: const Text('연락처'),
          child: Text(post.phone ?? ''),
        ),
        buildListTile(
          title: const Text('이메일'),
          child: Text(post.email ?? ''),
        ),
        buildListTile(
          title: const Text('내용'),
          child: Container(
            constraints: const BoxConstraints(minHeight: 300),
            child: Text(post.content),
          ),
        ),
        buildListTile(
          title: const Text('파일'),
          child: Column(
            children: List.generate(
              post.attachments?.length ?? 0,
              (index) {
                var file = post.attachments?[index];
                if (file == null) {
                  return const SizedBox.shrink();
                }
                var link = UtilStrapi.makeLink(file.url);
                return TextButton(
                  onPressed: link.isEmpty ? null : () => launch(link),
                  child: Text(file.name),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  ListTile buildListTile({
    required Widget title,
    required Widget child,
  }) {
    return ListTile(
      leading: title,
      title: child,
      dense: true,
      visualDensity: VisualDensity.compact,
      minLeadingWidth: 100.0,
    );
  }
}
