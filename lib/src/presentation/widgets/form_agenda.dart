import 'dart:io';

import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/misc/date_format.dart';
import 'package:agenda_app/src/presentation/misc/methods.dart';
import 'package:agenda_app/src/presentation/misc/validator.dart';
import 'package:agenda_app/src/presentation/providers/agenda_data/agenda_data_provider.dart';
import 'package:agenda_app/src/presentation/widgets/button.dart';
import 'package:agenda_app/src/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class FormAgenda extends ConsumerStatefulWidget {
  final bool isEdit;
  final Agenda? agenda;
  const FormAgenda({
    super.key,
    this.isEdit = false,
    this.agenda,
  });

  @override
  ConsumerState<FormAgenda> createState() => _FormAgendaState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateTimeController = TextEditingController();
TextEditingController timeRemanderController = TextEditingController();
TextEditingController attachmentController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

Uint8List? bytes;
File? imageFile;
String? dateFormat;

var reminderName = [
  '1 day before',
  '3 hours before',
  '1 hours before',
];

class _FormAgendaState extends ConsumerState<FormAgenda> {
  @override
  void initState() {
    if (widget.isEdit) {
      dateTimeController.text = FormatDate().formatDate(
          widget.agenda?.dateTime.toString(),
          context: context,
          format: 'EEE, dd MMM yyyy HH:mm');
      dateFormat = FormatDate().formatDate(widget.agenda?.dateTime.toString(),
          context: context, format: 'yyy-MM-dd HH:mm');
      titleController.text = widget.agenda?.title ?? '';
      descriptionController.text = widget.agenda?.description ?? '';
      timeRemanderController.text = widget.agenda?.timeReminder ?? '';
      attachmentController.text = widget.agenda?.imageName ?? '';
      if (widget.agenda != null) {
        bytes = Uint8List.fromList(widget.agenda!.imagePath!);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpace(20),
          KTextField(
            label: 'Title',
            maxLines: 1,
            minLines: 1,
            controller: titleController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: Validator.requiredValidator.call,
          ),
          verticalSpace(10),
          KTextField(
            label: 'Description',
            maxLines: 1,
            minLines: 1,
            controller: descriptionController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: Validator.requiredValidator.call,
          ),
          verticalSpace(10),
          KTextField(
            label: 'Date Time',
            maxLines: 1,
            minLines: 1,
            controller: dateTimeController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            isOption: true,
            validator: Validator.requiredValidator.call,
            onTap: () {
              DatePicker.showDateTimePicker(
                context,
                onConfirm: (value) {
                  dateTimeController.text = FormatDate().formatDate(
                      value.toString(),
                      context: context,
                      format: 'EEE, dd MMM yyyy HH:mm');
                  dateFormat = FormatDate().formatDate(value.toString(),
                      context: context, format: 'yyy-MM-dd HH:mm');
                  setState(() {});
                },
              );
            },
            suffixIcon: Container(
              decoration: BoxDecoration(
                color: saffron,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Icon(Icons.calendar_month),
            ),
          ),
          verticalSpace(10),
          KTextField(
            label: 'Reminder Time',
            maxLines: 1,
            minLines: 1,
            controller: timeRemanderController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            isOption: true,
            suffixIcon: Container(
              decoration: BoxDecoration(
                color: saffron,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Icon(Icons.notification_add),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Choose reminder timer',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: reminderName.length,
                            itemBuilder: (context, index) {
                              var item = reminderName[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    timeRemanderController.text = item;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    item,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          verticalSpace(10),
          KTextField(
            label: 'Attachment',
            maxLines: 1,
            minLines: 1,
            controller: attachmentController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            isOption: true,
            suffixIcon: Container(
              decoration: BoxDecoration(
                color: saffron,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Icon(Icons.upload_sharp),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                pickImage(ImageSource.camera);
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 45,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                pickImage(ImageSource.gallery);
                              },
                              icon: const Icon(
                                Icons.photo_size_select_actual_rounded,
                                size: 45,
                              ),
                            )
                          ],
                        ),
                      ));
            },
          ),
          verticalSpace(30),
          Button(
            isLoading: ref.watch(agendaDataProvider).isLoading,
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Agenda agenda = Agenda(
                  title: titleController.text,
                  description: descriptionController.text,
                  dateTime: dateFormat,
                  timeReminder: timeRemanderController.text,
                  imageName: attachmentController.text,
                  imagePath: bytes?.toList(),
                  id: widget.isEdit == true ? widget.agenda?.id : null,
                );
                widget.isEdit
                    ? ref.read(agendaDataProvider.notifier).updateAgenda(agenda)
                    : ref
                        .read(agendaDataProvider.notifier)
                        .createAgenda(agenda);
                Navigator.pop(context);
              }
            },
            child: const Center(
              child: Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ghostWhite,
                ),
              ),
            ),
          ),
          verticalSpace(20),
        ],
      ),
    );
  }

  Future pickImage(imageSource) async {
    try {
      final image = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 50,
      );
      if (image != null) {
        imageFile = File(image.path);
        attachmentController.text = image.name;
        bytes = await image.readAsBytes();
        setState(() {});
      }
      if (image == null) return;

      setState(() {});
    } on PlatformException catch (_) {}
  }
}
