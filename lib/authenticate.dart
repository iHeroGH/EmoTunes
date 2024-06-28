import 'package:emotunes/constants.dart';
import 'package:flutter/material.dart';

import 'background.dart';
import 'communicator.dart';
import 'custom_input_field.dart';
import 'log_in.dart';

class AuthPage extends StatefulWidget {
  final String emailAddress;

  const AuthPage({super.key, required this.emailAddress});

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
              child: AuthForm(authC: authC, emailAddress: widget.emailAddress)
            )
          ]
        )
      )
    );
  }
}

class AuthForm extends StatelessWidget {

  final TextEditingController authC;
  final String emailAddress;
  const AuthForm({super.key, required this.authC, required this.emailAddress});

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
                onPressed: () async { authPressed(context); },
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

  void authPressed(BuildContext context) async{
    Response resp = await Communicator.performAuthenticate(
      emailAddress, authC.text.trim()
    );

    if (!context.mounted) return;
    if (!resp.isSuccess){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          content: Text(resp.error)
        )
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LogInPage()
      )
    );
  }

}