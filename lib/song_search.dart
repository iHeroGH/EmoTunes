import 'package:emotunes/constants.dart';
import 'package:emotunes/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'background_plain.dart';
import 'communicator.dart';
import 'custom_input_field.dart';

class SongSearchPage extends StatefulWidget {
  final bool signUpHidden;

  const SongSearchPage({super.key, required this.signUpHidden});

  @override
  State<SongSearchPage> createState() => _SearchSongState();
}

class _SearchSongState extends State<SongSearchPage> {
  bool _isLoading = false;
  List<Map<String, dynamic>>? _songs;
  String _sentimentText = "";

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setSongs(List<Map<String, dynamic>> songs) {
    setState(() {
      _songs = songs;
    });
  }

  void _setSentiment(String sentimentText){
    _sentimentText = sentimentText;
  }

  bool get _hasSongs => _songs != null && _songs!.isNotEmpty;

  void _exportSongs() async {
    if (_hasSongs) {
      final resp = await Communicator.exportPlaylist(
        _songs!.map((song) => song['song_id']).join(' '), _sentimentText
      );

      await launchUrl(Uri.parse(resp.playlist));

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController sentimentC = TextEditingController();

    return Scaffold(
      floatingActionButton: widget.signUpHidden ? null : FloatingActionButton.extended(
        onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpPage()
            )
          );
        },
        label: const Text("Sign Up")
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.8,
              child: SearchForm(
                sentimentC: sentimentC,
                onLoadingChanged: _setLoading,
                onSongsChanged: _setSongs,
                exportEnabled: _hasSongs,
                onExportPressed: _exportSongs,
                onSearchPressed: _setSentiment
              ),
            ),
            if (_isLoading)
              const CircularProgressIndicator(),
            if (_songs != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _songs!.length,
                  itemBuilder: (context, index) {
                    final song = _songs![index];
                    return ListTile(
                      title: Text(song['song_name']),
                      subtitle: Text(song['artist']),
                      leading: Image.network(song['picture']),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  final TextEditingController sentimentC;
  final void Function(bool) onLoadingChanged;
  final void Function(String) onSearchPressed;
  final void Function(List<Map<String, dynamic>>) onSongsChanged;
  final bool exportEnabled;
  final VoidCallback onExportPressed;

  const SearchForm({
    super.key,
    required this.sentimentC,
    required this.onLoadingChanged,
    required this.onSearchPressed,
    required this.onSongsChanged,
    required this.exportEnabled,
    required this.onExportPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: CustomInputField(
                preIcon: Icons.email,
                controller: sentimentC,
                hintText: "How are you feeling?",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: dPadding),
              child: Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await searchPressed(context);
                    },
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
                  ElevatedButton(
                    onPressed: exportEnabled ? onExportPressed : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: const Text(
                      "Export",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchPressed(BuildContext context) async {
    onLoadingChanged(true);
    try {
      Response resp = await Communicator.findSongs(sentimentC.text);

      if (!resp.isSuccess) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
            content: Text(resp.error),
          ),
        );
        return;
      }

      onSearchPressed(sentimentC.text);
      onSongsChanged(resp.songs);
    } finally {
      onLoadingChanged(false);
    }
  }
}
