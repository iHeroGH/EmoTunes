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

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Log-In",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(
              width: size.width * 0.8,
              child: LogInForm()
            )
          ]
        )
      )
    );
  }
}

class LogInForm extends StatelessWidget {
  const LogInForm({Key? key});

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