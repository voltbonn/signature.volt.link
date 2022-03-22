import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeAppDemo extends StatefulWidget {
  const YoutubeAppDemo({Key? key}) : super(key: key);

  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'HpL0CgxJtz0',
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 600, height: 400, child: player),
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
                  ),
                ],
              );
            }
            return ListView(
              children: [
                Stack(
                  children: [
                    player,
                    Positioned.fill(
                      child: YoutubeValueBuilder(
                        controller: _controller,
                        builder: (context, value) {
                          return AnimatedCrossFade(
                            firstChild: const SizedBox.shrink(),
                            secondChild: Material(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      YoutubePlayerController.getThumbnail(
                                        videoId:
                                            _controller.params.playlist.first,
                                        quality: ThumbnailQuality.medium,
                                      ),
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            crossFadeState: value.isReady
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
