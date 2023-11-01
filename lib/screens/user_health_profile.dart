import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embelia/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../authentication/user_auth.dart';

class UserHealthProfile extends StatefulWidget {
  const UserHealthProfile({super.key});

  @override
  State<UserHealthProfile> createState() => _UserHealthProfileState();
}

class _UserHealthProfileState extends State<UserHealthProfile>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController(initialPage: 0);
  late AnimationController _lottieController;
  bool _isAnimating = true;

  @override
  void initState() {
    _isAnimating = true;
    _lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    Future.delayed(const Duration(seconds: 10), () {
      _lottieController.stop();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Hello There!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Ubuntu',
          ),
        ),
        backgroundColor: MyColor.primaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          "Embelia",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Raleway',
                            color: Color(MyColorHexCode.cerise),
                          ),
                        ),
                      ),
                      if (_isAnimating == true)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Expanded(
                            flex: 3,
                            child: AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                                RotateAnimatedText(
                                  'HAPPY',
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Raleway',
                                    color: Colors.black,
                                  ),
                                ),
                                RotateAnimatedText(
                                  'HEALTHY',
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Raleway',
                                    color: Colors.black,
                                  ),
                                ),
                                RotateAnimatedText(
                                  'HOLISTIC',
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Raleway',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                              onFinished: () {
                                setState(() {
                                  _isAnimating = false;
                                });
                              },
                            ),
                          ),
                        )
                      else
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Text(
                              "Your Personal Health Assistant",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    flex: 3,
                    child: Lottie.asset(
                      "assets/stickers/hello-bot.json",
                      frameBuilder: (context, child, composition) {
                        return AnimatedOpacity(
                          opacity: composition == null ? 0 : 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: child,
                        );
                      },
                      frameRate: FrameRate.max,
                      controller: _lottieController,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 15,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                transform: Matrix4.translationValues(5, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: PageView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    HealthProfileCard(
                      isMultipleAnswer: false,
                      question: "How old are you?",
                      min: 18,
                      max: 80,
                      questionID: "Age",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: false,
                      question: "What is your height (in cm)?",
                      min: 140,
                      max: 200,
                      questionID: "Height",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: false,
                      question: "What is your weight (in kg)?",
                      min: 40,
                      max: 150,
                      questionID: "Weight",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: false,
                      question: "How many hours do you sleep per night?",
                      min: 4,
                      max: 12,
                      questionID: "Avg. Hours of Sleep",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: false,
                      question:
                          "How many hours do you engage in physical activity per day?",
                      min: 0,
                      max: 5,
                      questionID: "Physical Activity Hours",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "Select your gender",
                      options: const ["Male", "Female"],
                      questionID: "Gender",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "Do you have any medical conditions?",
                      options: const ["No", "Yes"],
                      questionID: "Medical Conditions",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "Do you have any allergies?",
                      options: const ["No", "Yes"],
                      questionID: "Allergies",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "What is your dietary preference?",
                      options: const [
                        "Balanced",
                        "Vegetarian",
                        "Vegan",
                        "Non Vegetarian",
                        "Paleo",
                        "Keto"
                      ],
                      questionID: "Diet",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "What best describes your exercise routine?",
                      options: const [
                        "Regular",
                        "Irregular",
                        "Sedentary",
                        "Athletic"
                      ],
                      questionID: "Exercise Routine",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "What best describes your smoking habits?",
                      options: const [
                        "Non-Smoker",
                        "Smoker",
                        "Occasional",
                        "Former Smoker"
                      ],
                      questionID: "Smoking Habits",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "What best describes your alcohol consumption?",
                      options: const ["Low", "Moderate", "High", "Non-Drinker"],
                      questionID: "Alcohol Consumption",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "Do you use recreational drugs?",
                      options: const ["No", "Yes", "Recreational"],
                      questionID: "Recreational Drug Use",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "How would you rate your stress management?",
                      options: const ["Poor", "Good", "Moderate", "Excellent"],
                      questionID: "Stress Management",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question:
                          "Do you have a history of mental health issues?",
                      options: const [
                        "Stable",
                        "History",
                        "Depression",
                        "Anxiety"
                      ],
                      questionID: "Mental Health History",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question:
                          "Is there a family history of genetic conditions?",
                      options: const ["No", "Yes", "Genetic Conditions"],
                      questionID: "Family History",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "What best describes your sleep schedule?",
                      options: const [
                        "Regular",
                        "Irregular",
                        "Night Owl",
                        "Early Bird"
                      ],
                      questionID: "Sleep Schedule",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: false,
                      question:
                          "How many hours of screen time do you have daily?",
                      min: 1,
                      max: 10,
                      questionID: "Screen Time",
                      controller: _controller,
                    ),
                    HealthProfileCard(
                      isMultipleAnswer: true,
                      question: "What is your occupation?",
                      options: const [
                        "Office Job",
                        "Manual Labor",
                        "Student",
                        "Other",
                        "Healthcare Professional",
                        "Freelancer"
                      ],
                      questionID: "Occupation",
                      controller: _controller,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Expanded(
              flex: 1,
              child: Text(
                "*All data is stored anonymously",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthProfileCard extends StatefulWidget {
  final bool isMultipleAnswer;
  final String question;
  final String questionID;
  final List<String>? options;
  final PageController? controller;
  final double? min;
  final double? max;
  const HealthProfileCard(
      {super.key,
      required this.isMultipleAnswer,
      required this.question,
      this.options,
      required this.questionID,
      this.controller,
      this.min,
      this.max});

  @override
  State<HealthProfileCard> createState() => _HealthProfileCardState();
}

class _HealthProfileCardState extends State<HealthProfileCard> {
  final TextEditingController _controller = TextEditingController();

  List<String> features = [
    'Age',
    'Height',
    'Weight',
    'Avg. Hours of Sleep',
    'Physical Activity Hours',
    'Gender',
    'Medical Conditions',
    'Allergies',
    'Diet',
    'Exercise Routine',
    'Smoking Habits',
    'Alcohol Consumption',
    'Recreational Drug Use',
    'Stress Management',
    'Mental Health History',
    'Family History',
    'Sleep Schedule',
    'Screen Time',
    'Occupation',
  ];

  // Get Data from Firebase
  Map<String, dynamic> myFinalData = {};

  Future<void> getData() async {
    final data = FirebaseFirestore.instance.collection('users');
    var myData = await data.doc(UserAuth.userEmail).get();
    Map<String, dynamic> userData = {};
    userData = myData.data() as Map<String, dynamic>;

    for (String feature in userData.keys) {
      if (features.contains(feature)) {
        myFinalData[feature] = userData[feature];
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.question,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.isMultipleAnswer == true)
            Expanded(
              child: ListView.builder(
                itemCount: widget.options!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          side: const BorderSide(
                              width: 2.0, color: Colors.black45),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              widget.options![index],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Ubuntu'),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          // Add data to firebase
                          final data =
                              FirebaseFirestore.instance.collection('users');
                          await data.doc(UserAuth.userEmail).set({
                            widget.questionID: widget.options![index],
                          }, SetOptions(merge: true));

                          // Check if this is the last question, that is page-view index is 18
                          if (widget.controller!.page!.toInt() < 18) {
                            // Navigate to next page
                            widget.controller!.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutCubic);
                          } else {
                            // Navigate to next page
                            // await data.doc(UserAuth.userEmail).set({
                            //   'healthProfileCreated': true,
                            // }, SetOptions(merge: true)).then(
                            //   (value) async {
                            //     await getData().then(
                            //       (value) async {
                            //         await predictCustomHealthScore(userData)
                            //             .then(
                            //           (value) async {
                            //             print(value);
                            //           },
                            //         );
                            //       },
                            //     );
                            //   },
                            // );
                            await getData().then(
                              (value) async {
                                await predictCustomHealthScore(myFinalData)
                                    .then(
                                  (value) async {
                                    debugPrint(value.toString());
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            )
          else
            SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText:
                          "Enter value between ${widget.min!.ceil()} and ${widget.max!.ceil()}",
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        side:
                            const BorderSide(width: 1.0, color: Colors.black45),
                        primary: Colors.white,
                        onPrimary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Ubuntu'),
                      ),
                      onPressed: () {
                        if (double.parse(_controller.text) >= widget.min! &&
                            double.parse(_controller.text) <= widget.max!) {
                          // Add data to firebase
                          final data =
                              FirebaseFirestore.instance.collection('users');
                          data.doc(UserAuth.userEmail).set({
                            widget.questionID: _controller.text,
                          }, SetOptions(merge: true));

                          // Navigate to next page
                          widget.controller!.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOutCubic);
                        } else {
                          // Show alert dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Invalid Input",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                content: const Text(
                                  "Please enter a valid value",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Ubuntu',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        // Hide Keyboard
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<double> predictCustomHealthScore(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(
          'https://1eb9-2405-201-6834-3862-7c47-94d7-43f6-f662.ngrok.io/predict_custom_health_score'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      return result['custom_health_score'];
    } else {
      throw Exception('Failed to predict custom health score');
    }
  }

  //   // Sample data (make sure it matches the structure and feature names of your original data)

  //   // Normalize numeric features using Min-Max scaling
  //   userData['Age'] = (userData['Age'] - 18) / (80 - 18);
  //   userData['Height'] = (userData['Height'] - 140) / (200 - 140);
  //   userData['Weight'] = (userData['Weight'] - 40) / (150 - 40);
  //   userData['BMI'] = (userData['BMI'] - 15) / (40 - 15);
  //   userData['Avg. Hours of Sleep'] =
  //       (userData['Avg. Hours of Sleep'] - 4) / (12 - 4);
  //   userData['Physical Activity Hours'] =
  //       (userData['Physical Activity Hours'] - 0) / (5 - 0);
  //   userData['Screen Time'] = (userData['Screen Time'] - 1) / (10 - 1);
  //
  //   // Categorize categorical features using one-hot encoding
  //   userData['Gender_Male'] = 1;
  //   userData['Gender_Female'] = 0;
  //   userData['Medical Conditions_No'] = 1;
  //   userData['Medical Conditions_Yes'] = 0;
  //   userData['Allergies_No'] = 1;
  //   userData['Allergies_Yes'] = 0;
  //   userData['Diet_Balanced'] = 0;
  //   userData['Diet_Vegetarian'] = 0;
  //   userData['Diet_Vegan'] = 0;
  //   userData['Diet_Non Vegetarian'] = 0;
  //   userData['Diet_Paleo'] = 0;
  //   userData['Diet_Keto'] = 0;
  //   userData['Exercise Routine_Regular'] = 0;
  //   userData['Exercise Routine_Irregular'] = 0;
  //   userData['Exercise Routine_Sedentary'] = 0;
  //   userData['Exercise Routine_Athletic'] = 0;
  //   userData['Smoking Habits_Non-Smoker'] = 0;
  //   userData['Smoking Habits_Smoker'] = 0;
  //   userData['Smoking Habits_Occasional'] = 0;
  //   userData['Smoking Habits_Former Smoker'] = 0;
  //   userData['Alcohol Consumption_Low'] = 0;
  //   userData['Alcohol Consumption_Moderate'] = 0;
  //   userData['Alcohol Consumption_High'] = 0;
  //   userData['Alcohol Consumption_Non-Drinker'] = 0;
  //   userData['Recreational Drug Use_No'] = 0;
  //   userData['Recreational Drug Use_Yes'] = 0;
  //   userData['Recreational Drug Use_Recreational'] = 0;
  //   userData['Stress Management_Poor'] = 0;
  //   userData['Stress Management_Good'] = 0;
  //   userData['Stress Management_Moderate'] = 0;
  //   userData['Stress Management_Excellent'] = 0;
  //   userData['Mental Health History_Stable'] = 0;
  //   userData['Mental Health History_History'] = 0;
  //   userData['Mental Health History_Depression'] = 0;
  //   userData['Mental Health History_Anxiety'] = 0;
  //   userData['Family History_No'] = 0;
  //   userData['Family History_Yes'] = 0;
  //   userData['Family History_Genetic Conditions'] = 0;
  //   userData['Sleep Schedule_Regular'] = 0;
  //   userData['Sleep Schedule_Irregular'] = 0;
  //   userData['Sleep Schedule_Night Owl'] = 0;
  //   userData['Sleep Schedule_Early Bird'] = 0;
  //   userData['Occupation_Office Job'] = 0;
  //   userData['Occupation_Manual Labor'] = 0;
  //   userData['Occupation_Student'] = 0;
  //   userData['Occupation_Other'] = 0;
  //   userData['Occupation_Healthcare Professional'] = 0;
  //   userData['Occupation_Freelancer'] = 0;
  //
  //   // Assign values to categorical features
  //
  //   // Weights for each feature
  //   Map<String, dynamic> weights = {
  //     'Age': -0.1,
  //     'BMI': -0.1,
  //     'Avg. Hours of Sleep': 0.2,
  //     'Physical Activity Hours': 0.2,
  //     'Medical Conditions': -0.2,
  //     'Allergies': -0.05,
  //     'Screen Time': -0.1,
  //     'Diet_Keto': 0,
  //     'Diet_Non Vegetarian': 0,
  //     'Diet_Paleo': 0,
  //     'Diet_Vegan': 0.05,
  //     'Diet_Vegetarian': 0.05,
  //     'Exercise Routine_Irregular': -0.05,
  //     'Exercise Routine_Regular': 0.2,
  //     'Exercise Routine_Sedentary': -0.2,
  //     'Smoking Habits_Smoker': -0.2,
  //     'Smoking Habits_Non-Smoker': 0.1,
  //     'Alcohol Consumption_Low': 0.05,
  //     'Alcohol Consumption_Moderate': 0,
  //     'Alcohol Consumption_Non-Drinker': 0.05,
  //     'Recreational Drug Use_Recreational': -0.1,
  //     'Recreational Drug Use_Yes': -0.2,
  //     'Stress Management_Good': 0.2,
  //     'Stress Management_Moderate': 0,
  //     'Stress Management_Poor': -0.2,
  //     'Mental Health History_Depression': -0.2,
  //     'Mental Health History_History': -0.1,
  //     'Mental Health History_Stable': 0.1,
  //     'Family History_No': 0.05,
  //     'Family History_Yes': -0.05,
  //     'Sleep Schedule_Irregular': -0.1,
  //     'Sleep Schedule_Night Owl': -0.05,
  //     'Sleep Schedule_Regular': 0.1,
  //     'Occupation_Healthcare Professional': -0.1,
  //     'Occupation_Manual Labor': -0.05,
  //     'Occupation_Office Job': 0,
  //     'Occupation_Other': 0,
  //     'Occupation_Student': -0.05,
  //   };
  //
  //   // Calculate the custom health score based on the weighted factors
  //   double customHealthScore = 0.0;
  //
  //   for (String feature in weights.keys) {
  //     customHealthScore += userData[feature] * weights[feature];
  //   }
  //
  //   // Normalize the custom health score to a 0-100 range
  //   customHealthScore = (customHealthScore - 0) / (100 - 0) * 100;
  //
  //   // The 'customHealthScore' now contains the calculated health score for your sample data
  // }
}
