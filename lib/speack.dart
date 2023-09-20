import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeakPage extends StatefulWidget {
  const SpeakPage({super.key});

  @override
  State<SpeakPage> createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage> {
  SpeechToText speechToText = SpeechToText();
  TextEditingController textEditingController = TextEditingController();
  var text = 'parle je t\'ecoute';
  var ecouter = false;

  // void _saveText() {
  //   setState(() {
  //     textEditingController.text = text;
  //   });
  // }
  void _saveText() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${text.substring(0, 4)}.txt');

    await file.writeAsString(textEditingController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Texte enregistré avec succès')),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        glowColor:
            const Color.fromARGB(255, 194, 227, 255), // Couleur de la lueur
        endRadius: 75.0,
        showTwoGlows: true,
        animate: ecouter,

        repeatPauseDuration: Duration(microseconds: 100),
        child: GestureDetector(
          onTapDown: (details) async {
            if (!ecouter) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  ecouter = true;
                });
                speechToText.listen(
                  onResult: (result) {
                    setState(() {
                      text = result.recognizedWords;
                    });
                  },
                );
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              ecouter = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 87, 176, 250),
              radius: 35,
              child: Icon(
                ecouter ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              )),
        ),
      ),
      appBar: AppBar(
        leading: const Icon(
          Icons.sort_rounded,
          color: Colors.white,
        ),
        title: const Text(
          'parle seulement',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: _saveText,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              margin: EdgeInsets.only(bottom: 150),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            // if (!ecouter)
            //   Container(
            //     alignment: Alignment.center,
            //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            //     child: TextField(
            //       controller: textEditingController,
            //       decoration: const InputDecoration(
            //         labelText: 'Modifier le texte',
            //         border: OutlineInputBorder(),
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}
