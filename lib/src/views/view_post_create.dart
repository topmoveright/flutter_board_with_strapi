import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuonsoft/src/controllers/controller_post_create.dart';
import 'package:yuonsoft/src/core/utils/util_strapi.dart';
import 'package:yuonsoft/src/views/view_layout.dart';

const allowFileType = ['jpg', 'jpeg', 'png', 'gif', 'pdf', 'zip'];

class ViewPostCreate extends GetView<ControllerPostCreate> {
  const ViewPostCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewLayout(
      child: Center(
        child: SizedBox(
          width: 800,
          child: GetBuilder<ControllerPostCreate>(
            builder: (ctl) => Form(
              key: ctl.formKey,
              child: Column(
                children: [
                  buildFields(),
                  const SizedBox(height: 16),
                  buildExistAttachments(),
                  buildAddAttachments(),
                  const SizedBox(height: 40),
                  buildButtonBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildFields() {
    Widget _buildTextFormField({
      required TextEditingController controller,
      required Widget label,
      required FormFieldValidator<String> validator,
      bool isObscure = false,
      String hint = '',
      bool isTextarea = false,
    }) {
      return TextFormField(
        controller: controller,
        obscureText: isObscure,
        enableSuggestions: !isObscure,
        autocorrect: !isObscure,
        validator: validator,
        keyboardType: isTextarea ? TextInputType.multiline : TextInputType.text,
        maxLines: isTextarea ? null : 1,
        minLines: isTextarea ? 20 : 1,
        decoration: InputDecoration(
          hintText: hint,
          label: label,
        ),
      );
    }

    Widget _passwordField() => controller.isGuestBoard
        ? _buildTextFormField(
            isObscure: true,
            controller: controller.tecPassword,
            hint: '최소 4자리',
            label: const Text('비밀번호'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '비밀번호를 입력해 주세요.';
              } else if (value.length < 4) {
                return '최소 4자리 숫자를 입력해 주세요.';
              }
              return null;
            },
          )
        : const SizedBox.shrink();

    return Column(
      children: [
        CheckboxListTile(
          title: const Text('비밀글'),
          value: controller.private,
          onChanged: (val) {
            controller.private = val ?? false;
            controller.update();
          },
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        _passwordField(),
        _buildTextFormField(
          controller: controller.tecSubject,
          label: const Text('제목'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '제목을 입력해 주세요.';
            }
            return null;
          },
        ),
        _buildTextFormField(
          controller: controller.tecName,
          label: const Text('이름'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '이름을 입력해 주세요.';
            }
            return null;
          },
        ),
        _buildTextFormField(
          controller: controller.tecPhone,
          label: const Text('연락처'),
          hint: '010-0000-1111',
          validator: (value) {
            if ((value ?? '').isNotEmpty &&
                !GetUtils.isPhoneNumber(value ?? '')) {
              return '전화번호 형식을 확인해 주세요.';
            }
            return null;
          },
        ),
        _buildTextFormField(
          controller: controller.tecEmail,
          label: const Text('이메일'),
          hint: 'user@service.com',
          validator: (value) {
            if ((value ?? '').isNotEmpty && !GetUtils.isEmail(value ?? '')) {
              return '이메일 형식을 확인해 주세요.';
            }
            return null;
          },
        ),
        _buildTextFormField(
          controller: controller.tecContent,
          label: const Text('내용'),
          isTextarea: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '내용을 입력해 주세요.';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget buildExistAttachments() {
    return controller.isUpdate
        ? Column(
            children: List.generate(
              controller.tempAttachments.length,
              (index) {
                var file = controller.tempAttachments[index];
                if (file == null) {
                  return const SizedBox.shrink();
                }
                var link = UtilStrapi.makeLink(file.url);
                return ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => controller.removeTempAttachment(file),
                  ),
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: link.isEmpty ? null : () => launch(link),
                      child: Text(file.name),
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }

  Widget buildButtonBar() {
    return ButtonBar(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () => controller.actCreate(),
          child: const Text('등록'),
        ),
      ],
    );
  }

  Widget buildAddAttachments() {
    Widget _buildImageInput(Widget title, int index) {
      return ButtonBar(
        alignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: allowFileType,
              );
              if (result != null) {
                controller.files[index] = result.files.single;
                controller.update();
              }
            },
            child: title,
          ),
          const SizedBox(width: 4),
          Text(controller.files[index] != null
              ? controller.files[index]!.name
              : '...'),
          if (controller.files[index] != null)
            TextButton(
              onPressed: () {
                controller.files[index] = null;
                controller.update();
              },
              child: const Icon(Icons.close),
            ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('안내 - ${allowFileType.join(', ')} 확장자만 첨부가능(최대 10MB 이하)'),
        ...List.generate(
        controller.tempBoardAttachmentSize,
        (index) => _buildImageInput(Text('파일첨부 ${index + 1}'), index),
      )],
    );
  }
}
