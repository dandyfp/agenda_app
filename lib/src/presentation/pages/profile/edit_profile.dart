import 'dart:io';

import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/misc/date_format.dart';
import 'package:agenda_app/src/presentation/misc/methods.dart';
import 'package:agenda_app/src/presentation/providers/user_data/user_data_provider.dart';
import 'package:agenda_app/src/presentation/widgets/button.dart';
import 'package:agenda_app/src/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController dateOfBirthController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController photoProfileController = TextEditingController();

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  File? imageFile;
  String? imageName;
  User? userData;
  Uint8List? bytes;
  @override
  void initState() {
    ref.read(userDataProviderProvider.notifier).build();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProviderProvider,
      (previous, next) {
        if (next.value != null) {
          userData = next.value;
          firstNameController.text = next.value?.firstName ?? '';
          lastNameController.text = next.value?.firstName ?? '';
          emailController.text = next.value?.email ?? '';
          dateOfBirthController.text = next.value?.dateOfBirth ?? '';
          genderController.text = next.value?.gender ?? '';
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          'Edit Porfile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            verticalSpace(30),
            KTextField(
              label: 'First Name',
              maxLines: 1,
              minLines: 1,
              controller: firstNameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              borderColor: Colors.grey,
            ),
            verticalSpace(20),
            KTextField(
              label: 'Last Name',
              maxLines: 1,
              minLines: 1,
              controller: lastNameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              borderColor: Colors.grey,
            ),
            verticalSpace(20),
            KTextField(
              label: 'Email',
              maxLines: 1,
              minLines: 1,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              borderColor: Colors.grey,
            ),
            verticalSpace(20),
            KTextField(
              label: 'Date Of Birth',
              maxLines: 1,
              minLines: 1,
              isOption: true,
              controller: dateOfBirthController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              borderColor: Colors.grey,
              suffixIcon: Container(
                decoration: BoxDecoration(
                  color: saffron,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Icon(Icons.calendar_month),
              ),
              onTap: () {
                showDatePicker(context);
              },
            ),
            verticalSpace(20),
            KTextField(
              label: 'Gender',
              maxLines: 1,
              minLines: 1,
              controller: genderController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              borderColor: Colors.grey,
            ),
            verticalSpace(20),
            KTextField(
              label: 'Photo Profile',
              maxLines: 1,
              minLines: 1,
              isOption: true,
              controller: photoProfileController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.go,
              borderColor: Colors.grey,
              suffixIcon: Container(
                decoration: BoxDecoration(
                  color: saffron,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Icon(Icons.upload),
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
            verticalSpace(40),
            Button(
              onPressed: () {
                User user = User(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  dateOfBirth: dateOfBirthController.text,
                  gender: genderController.text,
                  id: userData?.id,
                  imagePath: bytes?.toList(),
                );
                ref.read(userDataProviderProvider.notifier).updateData(user);
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
            )
          ],
        ),
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
        imageName = image.name;
        photoProfileController.text = image.name;
        bytes = await image.readAsBytes();
        setState(() {});
      }
      if (image == null) return;

      setState(() {});
    } on PlatformException catch (_) {}
  }

  showDatePicker(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: whiteColor,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs value) {
                dateOfBirthController.text = FormatDate().formatDate(
                    value.value.toString(),
                    context: context,
                    format: 'dd MMMM yyyy');

                setState(() {});
              },
              selectionColor: saffron,
              todayHighlightColor: saffron,
              selectionMode: DateRangePickerSelectionMode.single,
              confirmText: 'Save',
              cancelText: 'Cancel',
              onCancel: () => Navigator.pop,
              onSubmit: (value) {
                dateOfBirthController.text = FormatDate().formatDate(
                    value.toString(),
                    context: context,
                    format: 'dd MMMM yyyy');

                setState(() {});
              },
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
