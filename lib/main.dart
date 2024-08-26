import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  return runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: saffron,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.poppins(color: Colors.black),
          bodyLarge: GoogleFonts.poppins(color: Colors.black),
          labelLarge: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
    );
  }
}
