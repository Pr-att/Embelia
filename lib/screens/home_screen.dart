import 'package:embelia/buttons/elevated_button/text_input.dart';
import 'package:embelia/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../authentication/auth_user.dart';
import '../authentication/user_data_constants.dart';
import 'faq.dart';
import 'initial_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.5,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: colors.primaryColor,
              ), child: null,
            ),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed('FAQ.id');
            }, child: const Text("FAQ")),
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
        flexibleSpace: Container(
          color: colors.primaryColor,
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 5.0,
                percent: 0.65,
                center: Center(
                  child: Lottie.network(
                      "https://assets10.lottiefiles.com/packages/lf20_5irvyy8e.json"),
                ),
                progressColor: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // const StepperWidget(),
            // SizedBox(
            //   height: 300,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: const [
            //       Padding(
            //         padding: EdgeInsets.only(left: 8),
            //         child: BreathingExercise(),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(left: 8),
            //         child: PushUps(),
            //       ),
            // Padding(
            //   padding: EdgeInsets.only(left: 8),
            //   child: DeadBug(),
            // ),
          ],
        ),
      ),
      // ),
      // ],
      // ),
    );
  }
}

// class HealthScore with ChangeNotifier {
//   var _value = 100.0;
//
//   double changeValue() {
//     _value = Random().nextInt(100).toDouble();
//     notifyListeners();
//     return _value;
//   }
// }
//
// class BreathingExercise extends StatefulWidget {
//   const BreathingExercise({super.key});
//
//   @override
//   State<BreathingExercise> createState() => _BreathingExerciseState();
// }
//
// class _BreathingExerciseState extends State<BreathingExercise>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer(const Duration(microseconds: 1), () {});
//     _controller = AnimationController(
//         vsync: this,
//         duration: const Duration(seconds: 5),
//         lowerBound: 0.0,
//         upperBound: 0.5);
//   }
//
//   void breatheExercise() {
//     _controller.forward();
//     Future.delayed(const Duration(seconds: 10), (() {
//       _controller.reverse();
//     }));
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 3,
//       width: 200,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12), color: Colors.grey[200]),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 15,
//           ),
//           Lottie.asset(
//             "assets/asset/breathing.json",
//             height: MediaQuery.of(context).size.height / 4.5,
//             width: 200,
//             controller: _controller,
//             frameRate: FrameRate(60),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           IconButton(
//             onPressed: () {
//               _timer.cancel();
//               _timer = Timer.periodic(const Duration(seconds: 18), (timer) {
//                 breatheExercise();
//               });
//               if (_controller.isAnimating || _controller.isCompleted) {
//                 _controller.reset();
//                 _timer.cancel();
//                 setState(() {});
//               } else {
//                 breatheExercise();
//                 _timer;
//                 setState(() {});
//               }
//             },
//             icon: Icon(
//               _controller.isAnimating ? Icons.pause_circle : Icons.play_circle,
//               size: 40,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PushUps extends StatefulWidget {
//   const PushUps({super.key});
//
//   @override
//   State<PushUps> createState() => _PushUpsState();
// }
//
// class _PushUpsState extends State<PushUps> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer(const Duration(microseconds: 1), () {});
//     _controller = AnimationController(
//         vsync: this,
//         duration: const Duration(seconds: 3),
//         lowerBound: 0.0,
//         upperBound: 0.5);
//   }
//
//   void breatheExercise() {
//     _controller.forward();
//     Future.delayed(const Duration(seconds: 3), (() {
//       _controller.reverse();
//     }));
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 3,
//       width: 200,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12), color: Colors.grey[200]),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 15,
//           ),
//           Lottie.asset(
//             "assets/asset/push-up.json",
//             height: MediaQuery.of(context).size.height / 4.5,
//             width: 200,
//             controller: _controller,
//             frameRate: FrameRate(60),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           IconButton(
//             onPressed: () {
//               _timer.cancel();
//               _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
//                 breatheExercise();
//               });
//               if (_controller.isAnimating || _controller.isCompleted) {
//                 _controller.reset();
//                 _timer.cancel();
//                 setState(() {});
//               } else {
//                 breatheExercise();
//                 _timer;
//                 setState(() {});
//               }
//             },
//             icon: Icon(
//               _controller.isAnimating ? Icons.pause_circle : Icons.play_circle,
//               size: 40,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DeadBug extends StatefulWidget {
//   const DeadBug({super.key});
//
//   @override
//   State<DeadBug> createState() => _DeadBugState();
// }
//
// class _DeadBugState extends State<DeadBug> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer(const Duration(microseconds: 1), () {});
//     _controller = AnimationController(
//         vsync: this,
//         duration: const Duration(seconds: 3),
//         lowerBound: 0.0,
//         upperBound: 0.5);
//   }
//
//   void breatheExercise() {
//     _controller.forward();
//     Future.delayed(const Duration(seconds: 3), (() {
//       _controller.reverse();
//     }));
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 3,
//       width: 200,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12), color: Colors.grey[200]),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 15,
//           ),
//           Lottie.network(
//             "https://assets7.lottiefiles.com/packages/lf20_zwrag2cg.json",
//             height: MediaQuery.of(context).size.height / 4.5,
//             width: 200,
//             controller: _controller,
//             frameRate: FrameRate(60),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           IconButton(
//             onPressed: () {
//               _timer.cancel();
//               _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
//                 breatheExercise();
//               });
//               if (_controller.isAnimating || _controller.isCompleted) {
//                 _controller.reset();
//                 _timer.cancel();
//                 setState(() {});
//               } else {
//                 breatheExercise();
//                 _timer;
//                 setState(() {});
//               }
//             },
//             icon: Icon(
//               _controller.isAnimating ? Icons.pause_circle : Icons.play_circle,
//               size: 40,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class StepperWidget extends StatefulWidget {
//   const StepperWidget({super.key});
//
//   @override
//   State<StepperWidget> createState() => _StepperWidgetState();
// }
//
// class _StepperWidgetState extends State<StepperWidget> {
//   _steps() => <Step>[
//         Step(
//           isActive: _currentStep == 0,
//           state: _stepState(0),
//           title: const Text('Start'),
//           content: const Text('hi'),
//         ),
//         Step(
//           isActive: _currentStep == 1,
//           state: _stepState(1),
//           title: const Text('Start'),
//           content: const Text('hi'),
//         ),
//         Step(
//           isActive: _currentStep == 2,
//           state: _stepState(2),
//           title: const Text('Start'),
//           content: const Text('hi'),
//         ),
//       ];
//   int _currentStep = 0;
//
//   StepState _stepState(int step) {
//     if (_currentStep > step) {
//       return StepState.complete;
//     } else {
//       return StepState.editing;
//     }
//   }
//
//   Widget controlsBuilder(
//       BuildContext context, ControlsDetails controlsDetails) {
//     return Row(
//       children: [
//         ElevatedButton(
//           onPressed: controlsDetails.onStepContinue,
//           child: const Text('Next'),
//         ),
//         if (_currentStep != 0)
//           TextButton(
//             onPressed: controlsDetails.onStepCancel,
//             child: const Text(
//               'Back',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//       ],
//     );
//   }
//
//   void onStepContinue() {
//     if (_currentStep < _steps().length - 1) {
//       setState(() {
//         _currentStep++;
//       });
//     } else {
//       setState(() {
//         _currentStep = 0;
//       });
//     }
//   }
//
//   void onStepCancel() {
//     if (_currentStep > 0) {
//       setState(() {
//         _currentStep--;
//       });
//     }
//   }
//
//   void onStepTapped(int index) {
//     setState(() {
//       _currentStep = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stepper(
//       currentStep: _currentStep,
//       steps: _steps(),
//       type: StepperType.vertical,
//       onStepContinue: onStepContinue,
//       onStepCancel: onStepCancel,
//       onStepTapped: onStepTapped,
//       controlsBuilder: controlsBuilder,
//     );
//   }
// }
