import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/pages/home/methods/floating_button.dart';
import 'package:agenda_app/src/presentation/providers/agenda_data/get_list_agenda_data_provider.dart';
import 'package:agenda_app/src/presentation/widgets/custom_drawer.dart';
import 'package:agenda_app/src/presentation/widgets/form_agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];
                  return ListTile(
                    title: Text(
                      item.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
        showModalBottomSheet(
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
              child: const FormAgenda(),
            );
          },
        );
      }),
    );
  }
}
