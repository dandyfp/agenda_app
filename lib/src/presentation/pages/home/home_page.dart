import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: ListView(),
    );
  }
}
