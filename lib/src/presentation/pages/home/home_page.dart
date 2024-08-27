import 'dart:typed_data';

import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/misc/date_format.dart';
import 'package:agenda_app/src/presentation/misc/methods.dart';
import 'package:agenda_app/src/presentation/pages/home/methods/floating_button.dart';
import 'package:agenda_app/src/presentation/providers/agenda_data/agenda_data_provider.dart';
import 'package:agenda_app/src/presentation/providers/agenda_data/get_list_agenda_data_provider.dart';
import 'package:agenda_app/src/presentation/widgets/button.dart';
import 'package:agenda_app/src/presentation/widgets/custom_drawer.dart';
import 'package:agenda_app/src/presentation/widgets/form_agenda.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isActiveSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'List Agenda',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: ref.watch(getListAgendaDataProvider).when(
            data: (data) {
              return data.isEmpty
                  ? const Center(
                      child: Text(
                        'Data is Empty',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var item = data[index];
                        return Card(
                          child: ExpansionTile(
                            onExpansionChanged: (value) {
                              if (item.timeReminder != '' && value == true) {
                                DateTime now = DateTime.now();
                                DateTime targetDateTime = item.timeReminder ==
                                        '1 day before'
                                    ? now.subtract(const Duration(days: -1))
                                    : item.timeReminder == '3 hours before'
                                        ? now
                                            .subtract(const Duration(hours: -3))
                                        : now.subtract(
                                            const Duration(hours: -1));
                                Duration difference =
                                    targetDateTime.difference(now);

                                bool isWithinOneDay =
                                    difference <= const Duration(days: 1);
                                bool isWithinThreeHours =
                                    difference <= const Duration(hours: 3);
                                bool isWithinOneHour =
                                    difference <= const Duration(hours: 1);

                                if (isWithinOneDay ||
                                    isWithinThreeHours ||
                                    isWithinOneHour) {
                                  AnimatedSnackBar.material(
                                          'Reminder ${item.title}, at ${item.dateTime}',
                                          type: AnimatedSnackBarType.info)
                                      .show(context);
                                }
                              }
                            },
                            expandedAlignment: Alignment.topLeft,
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showBottomSheetFormAgenda(
                                      context: context,
                                      agenda: item,
                                      isEdit: true,
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            verticalSpace(10),
                                            const Text(
                                              'are you sure you want to delete?',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            verticalSpace(20),
                                            Button(
                                              onPressed: () {
                                                ref
                                                    .read(agendaDataProvider
                                                        .notifier)
                                                    .deleteAgenda(item.id!);
                                                Navigator.pop(context);
                                              },
                                              child: const Center(
                                                child: Text(
                                                  'Delete',
                                                ),
                                              ),
                                            ),
                                            verticalSpace(10),
                                            Button(
                                              color: ghostWhite,
                                              border:
                                                  Border.all(color: saffron),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Center(
                                                child: Text(
                                                  'Cancel',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                horizontalSpace(5),
                                Text(
                                  item.title ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      item.description ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    verticalSpace(10),
                                    const Text(
                                      'Date Time',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      item.dateTime == null
                                          ? '-'
                                          : FormatDate().formatDate(
                                              item.dateTime.toString(),
                                              context: context,
                                              format: 'EEE, dd MMM yyyy HH:mm'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    verticalSpace(10),
                                    if (item.imagePath!.isNotEmpty)
                                      const Text(
                                        'Attachment',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    if (item.imagePath!.isNotEmpty)
                                      Container(
                                        width: 124,
                                        height: 124,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(
                                              Uint8List.fromList(
                                                  item.imagePath ?? []),
                                            ),
                                          ),
                                        ),
                                      ),
                                    verticalSpace(10),
                                    const Text(
                                      'Reminder',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Switch(
                                          value: item.timeReminder == null ||
                                                  item.timeReminder == ""
                                              ? isActiveSwitch
                                              : !isActiveSwitch,
                                          onChanged: (value) {
                                            // isActiveSwitch = value;
                                            if (value == true) {
                                              showBottomSheetFormAgenda(
                                                  context: context,
                                                  isEdit: true,
                                                  agenda: item);
                                            } else {
                                              Agenda agenda = Agenda(
                                                title: item.title,
                                                description: item.description,
                                                timeReminder: '',
                                                dateTime: item.dateTime,
                                                id: item.id,
                                                imageName: item.imageName,
                                                imagePath: item.imagePath,
                                              );
                                              ref
                                                  .read(agendaDataProvider
                                                      .notifier)
                                                  .updateAgenda(agenda);
                                            }

                                            // setState(() {});
                                          },
                                        ),
                                        Text(
                                          item.timeReminder ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      floatingActionButton: floatingButton(() {
        showBottomSheetFormAgenda(
          context: context,
          isEdit: false,
        );
      }),
    );
  }

  Future<dynamic> showBottomSheetFormAgenda({
    required BuildContext context,
    Agenda? agenda,
    required bool isEdit,
  }) {
    return showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 24.0,
              right: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: FormAgenda(
            isEdit: isEdit,
            agenda: agenda,
          ),
        );
      },
    );
  }
}
