import 'package:emotunes/constants.dart';
import 'package:flutter/material.dart';
import 'background.dart';
import 'custom_input_field.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInState();
}

class _LogInState extends State<LogInPage>{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailC = TextEditingController();
    TextEditingController passwordC = TextEditingController();

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.8,
              child: LogInForm(emailC: emailC, passwordC: passwordC)
            )
          ]
        )
      )
    );
  }
}

class LogInForm extends StatelessWidget {
  final TextEditingController emailC;
  final TextEditingController passwordC;

  const LogInForm({super.key, required this.emailC, required this.passwordC});

  @override
  Widget build(BuildContext context) {

    return Form(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: dPadding),
              child: CustomInputField(
                preIcon: Icons.email,
                controller: emailC,
                hintText: "Email Address",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: dPadding),
              child: CustomInputField(
                preIcon: Icons.password,
                postIcon: Icons.visibility,
                postIconOpt: Icons.visibility_off,
                hintText: "Password",
                controller: passwordC,
                visibility: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: dPadding),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}