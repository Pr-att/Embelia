import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class FAQ extends StatefulWidget {
  static const String id = "FAQ";
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final TextEditingController _controller = TextEditingController();

  // FUnction to get the answer from the API
  Future getFAQAnswer(question) async {
    http.Response res = await http.get(
      Uri.parse("$uri/$question"),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return "Error";
    }
  }

  // Variable to store the answer
  String _answer = "Mental Health";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "FAQ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: colors.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                        alignment: Alignment.center, child: Text(_answer)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Write your query here ...",
                    labelText: "Query",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      side: const BorderSide(color: Colors.black, width: 2),
                    ),
                    onPressed: () async {
                      var response = await getFAQAnswer(_controller.text);
                      if (_controller.text.isEmpty) {
                        return;
                      }
                      _answer = response;
                      setState(() {});
                    },
                    child: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
