import 'package:emotunes/constants.dart';
import 'package:flutter/material.dart';
import 'background.dart';
import 'custom_input_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthState();
}

class _AuthState extends State<AuthPage>{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController authC = TextEditingController();

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.8,
              child: AuthForm(authC: authC)
            )
          ]
        )
      )
    );
  }
}

class AuthForm extends StatelessWidget {
  final TextEditingController authC;
  const AuthForm({super.key, required this.authC});

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
                controller: authC,
                preIcon: Icons.key,
                hintText: "Authentication Code",
                maxLength: 6,
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
                  "Authenticate",
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