import 'dart:convert';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts = FlutterTts();
  List<Map<String, String>> availableVoices = [];

  @override
  void initState() {
    super.initState();
    initializeTTS();
  }

  Future<void> initializeTTS() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts
        .setSpeechRate(0.3); // Set the rate to 0.5 for slower speech
    // await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    // await flutterTts.setVoice({
    //   "locale": "en-AU",
    //   "quality": "default",
    //   "identifier": "com.apple.voice.compact.en-AU.Karen",
    //   "name": "Karen",
    //   "gender": "female"
    // });

    List<Object?> voices = await flutterTts.getVoices;

    availableVoices = voices
        .cast<Map<Object?, Object?>>()
        .map((map) =>
            Map<String, String>.fromEntries(map.entries.map((entry) => MapEntry(
                  entry.key.toString(),
                  entry.value.toString(),
                ))))
        .where((element) => element['locale']!.contains('-US'))
        // .where((element) => element['name']! == "Karen")
        .toList();

    // availableVoices
    //     .where((element) => element['name']! == "Karen")
    //     .forEach((element) => print(element));

    // availableVoices = voices.whereType<Map<String, String>>().map((voice) {
    //   return voice['name'] ?? 'Unknown'; // Use a default name if 'name' is null
    // }).toList();

    setState(() {}); // Trigger a rebuild after getting available voices
  }

  Future<void> playTTS(Map<String, String> voice) async {
    await flutterTts.setVoice(voice);
    await flutterTts.stop();
    await flutterTts.speak("Hello, welcome to Flutter TTS!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TTS Voices"),
      ),
      body: ListView.builder(
        itemCount: availableVoices.length,
        itemBuilder: (context, index) {
          // var name = availableVoices[index]['name']!;
          return ListTile(
            title: Text(jsonEncode(availableVoices[index])),
            onTap: () {
              playTTS(availableVoices[index]);
            },
          );
        },
      ),
    );
  }
}
