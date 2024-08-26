import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/misc/methods.dart';
import 'package:agenda_app/src/presentation/misc/navigator_helper.dart';
import 'package:agenda_app/src/presentation/pages/home/home_page.dart';
import 'package:agenda_app/src/presentation/providers/user_data/user_data_provider.dart';
import 'package:agenda_app/src/presentation/widgets/button.dart';
import 'package:agenda_app/src/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KTextField(
                maxLines: 1,
                minLines: 1,
                label: 'Email',
                borderColor: Colors.grey,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: emailController,
              ),
              verticalSpace(20),
              KTextField(
                maxLines: 1,
                minLines: 1,
                label: 'Password',
                borderColor: Colors.grey,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.go,
                controller: passwordController,
                obscure: isObscure,
                suffixIcon: InkWell(
                  onTap: () => setState(
                    () {
                      isObscure = !isObscure;
                    },
                  ),
                  child: Icon(
                    isObscure == true ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              verticalSpace(40),
              Button(
                onPressed: () {
                  User user = const User(
                    firstName: 'Acount',
                    lastName: 'guest',
                    dateOfBirth: '-',
                    email: '-',
                    gender: '-',
                    password: '-',
                  );
                  if (ref.watch(userDataProviderProvider).value == null) {
                    ref.read(userDataProviderProvider.notifier).create(user);
                    NavigatorHelper.push(context, const HomePage());
                  } else {
                    NavigatorHelper.push(context, const HomePage());
                  }
                },
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ghostWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
