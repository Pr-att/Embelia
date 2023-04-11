import 'package:embelia/constants.dart';
import 'package:embelia/screens/home_screen.dart';
import 'package:embelia/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import '../authentication/user_data_constants.dart';
import '../buttons/elevated_button/elevated_button.dart';
import '../buttons/elevated_button/text_input.dart';

var _userEmail;
var _userPassword;
final myHiveBox = Hive.box('LocalDB');
var inputPass;
String error = '';

class SignInScreen extends StatefulWidget with ChangeNotifier {
  SignInScreen({Key? key}) : super(key: key);
  static String id = "SignInScreen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _userPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                Color(0xff000000),
                Color(0xff150050),
                Color(0xff000000),
                Color(0xff000000),
              ])),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 70,
              child: Image.asset(
                "assets/asset/google_icon.png",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                InputButton(
                  onSave: (String? value) {
                    setState(() {
                      email = value;
                      kUserEmail = email;
                    });
                  },
                  onValidate: (value) {
                    return (value!.isEmpty ||
                            !RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value))
                        ? 'Enter correct email'
                        : null;
                  },
                  hintText: 'Where do people email you?',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  labelText: 'Email *',
                  initialValue: '',
                  obsecureText: false,
                ),
                InputButton(
                  onSave: (String? value) {
                    setState(() {
                      kUserPassword = value;
                      inputPass = value;
                    });
                  },
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return 'Enter correct name';
                    } else if (value.length < 8) {
                      return "Password should be at least 8 characters";
                    } else {
                      return null;
                    }
                  },
                  hintText: 'Sshh.. 🤫 It\'s Secret',
                  keyboardType: TextInputType.name,
                  icon: Icons.password,
                  labelText: 'Password *',
                  initialValue: '',
                  obsecureText: _userPassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: ScreenWidth / 3),
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          if (_userPassword == true) {
                            setState(() {
                              _userPassword = false;
                            });
                          } else {
                            setState(() {
                              _userPassword = true;
                            });
                          }
                        },
                        icon: const FaIcon(FontAwesomeIcons.eye),
                      ),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  icon: const Icon(
                    Icons.safety_check,
                    color: Colors.black,
                  ),
                  myFunc: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Are you sure you want to submit?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, "Cancel"),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (readData(kUserEmail) == null) {
                                  Navigator.pushNamed(
                                      context, RegistrationScreen.id);
                                } else if (readData(kUserEmail) != null &&
                                    getPassByKey(kUserEmail) != inputPass) {
                                  setState(() {
                                    error = "Incorrect Password";
                                  });
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    error = '';
                                  });
                                  Navigator.pushNamed(context, HomeScreen.id);
                                  print(userImageUrl);
                                  print(getPhotoByKey(kUserEmail));
                                }
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                  myText: 'Submit',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
