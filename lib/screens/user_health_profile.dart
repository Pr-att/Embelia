import 'package:embelia/constants.dart';
import 'package:flutter/material.dart';

class UserHealthProfile extends StatelessWidget {
  const UserHealthProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Health Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyColor.primaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: PageView(
            children: const [
              HealthProfileCard(
                isMultipleAnswer: false,
                question: "How old are you?",
                options: ["Option 1", "Option 2", "Option 3", "Option 4"],
                questionID: "Age",
              ),
              HealthProfileCard(
                isMultipleAnswer: false,
                question:
                    "What is your height in feet and inches (or centimeters)?",
                options: ["Option 1", "Option 2", "Option 3", "Option 4"],
                questionID: "Height",
              ),
              HealthProfileCard(
                isMultipleAnswer: false,
                question:
                    "What is your current weight in pounds (or kilograms)?",
                options: ["Option 1", "Option 2", "Option 3", "Option 4"],
                questionID: "Weight",
              ),
              HealthProfileCard(
                isMultipleAnswer: false,
                question:
                    "How many hours of sleep do you typically get per night on average?",
                options: ["Option 1", "Option 2", "Option 3", "Option 4"],
                questionID: "Avg. Hours of Sleep",
              ),
              HealthProfileCard(
                isMultipleAnswer: false,
                question:
                    "How many hours a week do you engage in physical activity or exercise?",
                options: ["Option 1", "Option 2", "Option 3", "Option 4"],
                questionID: "Physical Activity Hours",
              ),
              HealthProfileCard(
                isMultipleAnswer: false,
                question: "What is your gender?",
                options: ["Male", "Female"],
                questionID: "Gender",
              ),
              HealthProfileCard(
                isMultipleAnswer: false,
                question:
                    "Do you have any existing medical conditions or illnesses?",
                options: ["Option 1", "Option 2", "Option 3", "Option 4"],
                questionID: "Medical Conditions",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HealthProfileCard extends StatelessWidget {
  final bool isMultipleAnswer;
  final String question;
  final String questionID;
  final List<String>? options;
  const HealthProfileCard(
      {super.key,
      required this.isMultipleAnswer,
      required this.question,
      this.options,
      required this.questionID});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      transform: Matrix4.translationValues(5, 5, 0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              options![0],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              options![1],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              options![2],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
