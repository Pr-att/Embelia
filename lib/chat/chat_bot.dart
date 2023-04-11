import 'package:embelia/widgets/feature_box.dart';
import 'package:embelia/widgets/pallets.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);
  static const String id = "ChatBot";

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final speechToText = SpeechToText();
  String lastWords = "";

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  // Future<void> initTextToSpeech() async {
  //   await flutterTts.setSharedInstance(true);
  //   setState(() {});
  // }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  // Future<void> systemSpeak(String content) async {
  //   await flutterTts.speak(content);
  // }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    // flutterTts.stop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ChatBot"),
          leading: const Icon(Icons.menu),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape
                            .circle, // You can use like this way or like the below line
                      ),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/assets/images/virtualAssistant.png"),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 40)
                    .copyWith(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Pallete.borderColor),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Hi, I am your virtual assistant. How can I help you?",
                    style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: 25,
                      fontFamily: "Cera Pro",
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10, left: 22),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Here are a few commands you can try:",
                  style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: 20,
                    fontFamily: "Cera Pro",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: const [
                  FeatureBox(
                      color: Pallete.firstSuggestionBoxColor,
                      headerText: "ChatGPT",
                      descriptionText:
                          "A chatbot that uses GPT-3 to generate responses"),
                  FeatureBox(
                      color: Pallete.secondSuggestionBoxColor,
                      headerText: "Dall-E",
                      descriptionText:
                          "Get Inspired by Dall-E, an AI that generates images from text"),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: const Icon(Icons.mic),
        ));
  }
}
