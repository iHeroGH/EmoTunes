import 'package:emotunes/constants.dart';
import 'package:flutter/material.dart';

import 'background.dart';
import 'custom_input_field.dart';

class SongSearchPage extends StatefulWidget {
  const SongSearchPage({super.key});

  @override
  State<SongSearchPage> createState() => _SearchSongState();
}

class _SearchSongState extends State<SongSearchPage>{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController sentimentC = TextEditingController();

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.8,
              child: SearchForm(sentimentC: sentimentC)
            )
          ]
        )
      )
    );
  }
}

class SearchForm extends StatelessWidget {
  final TextEditingController sentimentC;

  const SearchForm({super.key, required this.sentimentC});

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
                controller: sentimentC,
                hintText: "How are you feeling?",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: dPadding),
              child: ElevatedButton(
                onPressed: () async { searchPressed(context); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: const Text(
                  "Search",
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

  void searchPressed(BuildContext context) async{
    // Response resp = await Communicator.performLogin(
    //   emailC.text, passwordC.text
    // );

    // if (!resp.isSuccess){
    //   if (!context.mounted) return false;
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       duration: const Duration(seconds: 5),
    //       content: Text(resp.error)
    //     )
    //   );
    //   return false;
    // }

    // return true;
  }
}