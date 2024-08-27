import 'dart:typed_data';

import 'package:agenda_app/src/data/datasource/db_helper.dart';
import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/misc/methods.dart';
import 'package:agenda_app/src/presentation/misc/navigator_helper.dart';
import 'package:agenda_app/src/presentation/pages/auth/login_page.dart';
import 'package:agenda_app/src/presentation/pages/profile/edit_profile.dart';
import 'package:agenda_app/src/presentation/providers/user_data/user_data_provider.dart';
import 'package:agenda_app/src/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = ref.watch(userDataProviderProvider).value;
    return SafeArea(
      child: Drawer(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(20),
            const Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            verticalSpace(20),
            Center(
              child: user?.imagePath != null
                  ? Container(
                      width: 124,
                      height: 124,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(
                            Uint8List.fromList(user?.imagePath ?? []),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 124,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFB1A7A6), width: 3),
                      ),
                      child: const Center(
                        child: CircleAvatar(
                          radius: 62,
                          backgroundColor: whiteColor,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
            ),
            verticalSpace(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    '${user?.firstName} ${user?.lastName}',
                  ),
                  verticalSpace(10),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    user?.email ?? '-',
                  ),
                  verticalSpace(10),
                  const Text(
                    'Date Of Birth',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    user?.dateOfBirth ?? '-',
                  ),
                  verticalSpace(10),
                  const Text(
                    'Gender',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  verticalSpace(4),
                  Text(user?.gender ?? '-')
                ],
              ),
            ),
            verticalSpace(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Button(
                onPressed: () {
                  NavigatorHelper.push(context, const EditProfilePage());
                  ref.read(userDataProviderProvider.notifier).build();
                },
                child: const Center(
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ghostWhite,
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Button(
                color: ghostWhite,
                border: Border.all(color: saffron),
                onPressed: () {
                  clearSession();

                  NavigatorHelper.pushAndRemoveUntil(
                    context,
                    const LoginPage(),
                    (route) => false,
                  );
                },
                child: const Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: saffron,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> clearSession() async {
    await asyncPrefs.clear();
    await DatabaseHelper().dropTable();
  }
}
