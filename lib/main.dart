import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DrumPage(),
    );
  }
}

class DrumPage extends StatefulWidget {
  const DrumPage({super.key});

  @override
  State<DrumPage> createState() => _DrumPageState();
}

class _DrumPageState extends State<DrumPage> {
  final List<AudioPlayer> _players = [];

  Future<void> _playSound(String soundFile) async {
    final player = AudioPlayer();
    _players.add(player);
    await player.play(AssetSource('sounds/$soundFile'));
    player.onPlayerComplete.listen((_) {
      player.dispose();
      _players.remove(player);
    });
  }

  @override
  void dispose() {
    for (final player in _players) {
      player.dispose();
    }
    _players.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          // Background image - fills the entire screen
          Positioned.fill(
            child: Image.asset('assets/images/drum.png', fit: BoxFit.contain),
          ),
          // Buttons overlay
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _playSound('h1.wav'),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _playSound('h2.wav'),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _playSound('c1.wav'),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _playSound('c2.wav'),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _playSound('k1.wav'),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _playSound('k2.wav'),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
