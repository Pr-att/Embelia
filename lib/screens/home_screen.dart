import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embelia/authentication/user_data.dart';
import 'package:embelia/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../authentication/user_auth.dart';
import 'faq.dart';
import 'initial_screen.dart';

class HomeScreen extends StatefulWidget with ChangeNotifier {
  HomeScreen({Key? key}) : super(key: key);
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    UserData().getUserData(context);
    super.initState();
  }

  bool _isHealthy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.5,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: MyColor.primaryColor,
              ),
              child: null,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(FAQ.id);
                },
                child: const Text("FAQ")),
            IconButton(
              onPressed: () {
                context.read<UserAuth>().signOutFromGoogle();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    InitialScreen.id, ModalRoute.withName(HomeScreen.id));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyColor.primaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            FirebaseFirestore.instance
                .collection('users')
                .doc(context.read<UserAuth>().tempGoogleIDEmail)
                .snapshots()
                .listen((DocumentSnapshot documentSnapshot) {
              healthScore = documentSnapshot['healthScore'] ?? 0;
              totalTask = documentSnapshot['totalTask'] ?? 0;
              prizeMoney = documentSnapshot['prizeMoney'] ?? 0;
              streak = documentSnapshot['streak'] ?? 0;
            });

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColor.lightGreyShade,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.fireplace_rounded,
                                color: Colors.red[700],
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text((streak ?? 0).toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColor.lightGreyShade,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Colors.amber[700],
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text((prizeMoney ?? 0).toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const StepperWidget(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Welcome to Embelia"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.read<UserAuth>().name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CircularPercentIndicator(
                  lineWidth: 10,
                  center: Text(
                    "${(healthScore ?? 0).toString()}%",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  radius: 90,
                  progressColor: _progressColor(healthScore ?? 0),
                  percent: (healthScore ?? 0) / 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Your Tasks!"),
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width - 5,
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Card(
                        child: CheckboxListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          subtitle: const Text("Check if you are healthy"),
                          tileColor: Colors.green[100],
                          activeColor: Colors.deepOrange,
                          title: Text(
                              _isHealthy == true ? "Healthy" : "Unhealthy"),
                          value: _isHealthy,
                          onChanged: (value) {
                            setState(() {
                              _isHealthy = value!;
                            });
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          }),

      // ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer), label: "Menu"),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushNamed(FAQ.id);
          }
          if (index == 2) {
            Navigator.of(context).pushNamed(FAQ.id);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          healthScore = Random().nextInt(100);
          totalTask = Random().nextInt(100);
          prizeMoney = Random().nextInt(100);
          streak = Random().nextInt(100);
          await UserData().userDataUpdate(context);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

Color _progressColor(int value) {
  if (value < 35) {
    return Colors.red;
  } else if (value < 65) {
    return Colors.yellow;
  } else {
    return Colors.green;
  }
}

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key});

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  _steps() => <Step>[
        Step(
          isActive: _currentStep == 0,
          state: _stepState(0),
          title: const Text('Start'),
          content: const Text('hi'),
        ),
        Step(
          isActive: _currentStep == 1,
          state: _stepState(1),
          title: const Text('Start'),
          content: const Text('hi'),
        ),
        Step(
          isActive: _currentStep == 2,
          state: _stepState(2),
          title: const Text('Start'),
          content: const Text('hi'),
        ),
      ];
  int _currentStep = 0;

  StepState _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  Widget controlsBuilder(
      BuildContext context, ControlsDetails controlsDetails) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: controlsDetails.onStepContinue,
          child: const Text('Next'),
        ),
        if (_currentStep != 0)
          TextButton(
            onPressed: controlsDetails.onStepCancel,
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }

  void onStepContinue() {
    if (_currentStep < _steps().length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      setState(() {
        _currentStep = 0;
      });
    }
  }

  void onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void onStepTapped(int index) {
    setState(() {
      _currentStep = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      steps: _steps(),
      type: StepperType.vertical,
      onStepContinue: onStepContinue,
      onStepCancel: onStepCancel,
      onStepTapped: onStepTapped,
      controlsBuilder: controlsBuilder,
    );
  }
}
