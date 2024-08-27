import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:agenda_app/src/presentation/misc/constant.dart';
import 'package:agenda_app/src/presentation/misc/methods.dart';
import 'package:agenda_app/src/presentation/misc/navigator_helper.dart';
import 'package:agenda_app/src/presentation/misc/validator.dart';
import 'package:agenda_app/src/presentation/pages/home/home_page.dart';
import 'package:agenda_app/src/presentation/providers/user_data/user_data_provider.dart';
import 'package:agenda_app/src/presentation/widgets/button.dart';
import 'package:agenda_app/src/presentation/widgets/textfield.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isObscure = true;
  bool? isLogin;

  @override
  void initState() {
    checkState();
    super.initState();
  }

  checkState() async {
    await getBool();
    if (isLogin == true) {
      setState(() {
        Future.delayed(Durations.medium1, () => goToHome());
      });
    }
  }

  goToHome() => NavigatorHelper.pushReplacement(context, const HomePage());

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
              Image.asset(
                height: 200,
                width: 200,
                'assets/logo.png',
              ),
              verticalSpace(20),
              KTextField(
                maxLines: 1,
                minLines: 1,
                label: 'Email',
                borderColor: Colors.grey,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: emailController,
                validator: Validator.emailValidator.call,
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
                validator: Validator.passwordValidator.call,
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
                  if (formKey.currentState?.validate() ?? false) {
                    if (emailController.text ==
                            'candidate@deptechdigital.com' &&
                        passwordController.text == 'testInterview123!') {
                      setBool();
                      ref.read(userDataProviderProvider.notifier).create(user);
                      NavigatorHelper.pushAndRemoveUntil(
                        context,
                        const HomePage(),
                        (route) => false,
                      );
                    } else {
                      AnimatedSnackBar.material(
                        'Wrong email or password',
                        type: AnimatedSnackBarType.warning,
                      ).show(context);
                    }
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
              verticalSpace(20),
              TextButton(
                onPressed: () =>
                    NavigatorHelper.pushReplacement(context, const HomePage()),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setBool() async {
    await asyncPrefs.setBool('login', true);
  }

  Future<void> getBool() async {
    isLogin = await asyncPrefs.getBool('login');
  }
}
