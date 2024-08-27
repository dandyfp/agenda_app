import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:flutter/material.dart';

Widget floatingButton(VoidCallback? onTap) => InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          bottom: 45,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: saffron,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              size: 35,
            ),
            Text(
              'Add Agenda',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
