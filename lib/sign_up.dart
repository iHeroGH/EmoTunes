import 'package:emotunes/constants.dart';
import 'package:flutter/material.dart';
import 'background.dart';
import 'custom_input_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage>{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController firstNameC = TextEditingController();
    TextEditingController lastNameC = TextEditingController();
    TextEditingController emailC = TextEditingController();
    TextEditingController passwordC = TextEditingController();

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.8,
              child: SignUpForm(
                firstNameC: firstNameC,
                lastNameC: lastNameC,
                emailC: emailC,
                passwordC: passwordC
              )
            )
          ]
        )
      )
    );
  }
}

class SignUpForm extends StatelessWidget {

  final TextEditingController firstNameC;
  final TextEditingController lastNameC;
  final TextEditingController emailC;
  final TextEditingController passwordC;

  const SignUpForm(
    {
      super.key,
      required this.firstNameC,
      required this.lastNameC,
      required this.emailC,
      required this.passwordC,
    }
  );

  @override
  Widget build(BuildContext context) {

    return Form(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: dPadding, bottom: dPadding, right: 5),
                    child: CustomInputField(
                      hintText: "First Name",
                      controller: firstNameC,
                      preIcon: Icons.account_circle
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: dPadding, bottom: dPadding),
                    child: CustomInputField(controller: lastNameC, hintText: "Last Initial", maxLength: 1),
                  ),
                ),
              ],
            ),
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
                controller: passwordC,
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
                onPressed: () { signUpPressed(); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: const Text(
                  "Sign Up",
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

  void signUpPressed (){
    print(firstNameC.text);
    print(lastNameC.text);
    print(emailC.text);
    print(passwordC.text);
  }
}