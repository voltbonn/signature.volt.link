import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SignatureHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = YoutubePlayerController(
      initialVideoId: 'K18cpp_-gP8',
      params: const YoutubePlayerParams(
        playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
        startAt: Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: 400,
        width: 1080,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "🎉",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Deine Mail Signatur!',
                        style: Theme.of(context).textTheme.headline2,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  YoutubePlayerIFrame(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Fast geschafft, lass uns nun Deine Signatur einbinden",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "1. Klicke hier um den HTML Editor zu öffnen",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "2. Setze Deine Signatur auf der linken Seite ein.",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "3. Drücke auf den grünnen Button Run.",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "4. Kopiere Deine Signatur von der rechten Seite in dem Du die Signatur makierst.",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "5. Öffne Gmail.",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "6. Gehe in die Einstellungen.",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "7. Klicke auf \"Alle Einstellungen\".",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "8. Scrolle runter zu Signatur und klick \"Neu erstellen\"",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "9. Füge nun Deine Signatur im rechten freien Feld ein.",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "10. Klicke auf \"Änderungen speichern\".",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
