import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:voctext/speack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parle j\'écris',
      home: SpeakPage(),
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//  late stt.SpeechToText _speech;
//   String _text = '';

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (await _speech.initialize()) {
//       if (!_speech.isListening) {
//         _speech.listen(
//           onResult: (result) {
//             setState(() {
//               _text = result.recognizedWords;
//             });
//           },
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Speech-to-Text Flutter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Texte reconnu :'),
//             SizedBox(height: 10),
//             Text(_text),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _listen,
//               child: Text('Cliquer pour écouter'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
