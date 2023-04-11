import 'package:embelia/authentication/auth_user.dart';
import 'package:embelia/buttons/elevated_button/elevated_button.dart';
import 'package:embelia/screens/home_screen.dart';
import 'package:embelia/screens/sign_in_screen.dart';
import 'package:embelia/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../authentication/user_data_constants.dart';

// Hive Container Box
final myHiveBox = Hive.box('LocalDB');

class InputTextButton extends StatefulWidget {
  static const id = "InputTextButton";
  const InputTextButton({super.key});

  @override
  State<InputTextButton> createState() => _InputTextButtonState();
}

class _InputTextButtonState extends State<InputTextButton> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var nameListenProvider = context.watch<UserAuth>().tempGoogleIDName;
    var emailListenProvider = context.watch<UserAuth>().tempGoogleIDEmail;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputButton(
            onSave: (String? value) {
              setState(() {
                kUserName = value;
                name = nameListenProvider ?? value ?? '';
              });
            },
            onValidate: (value) {
              return (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value))
                  ? 'Enter correct name'
                  : null;
            },
            hintText: 'What do people call you?',
            keyboardType: TextInputType.name,
            icon: Icons.person,
            labelText: 'Name *',
            initialValue: nameListenProvider ?? kUserName ?? '',
            obsecureText: false,
          ),
          InputButton(
            onSave: (String? value) {
              setState(() {
                email = emailListenProvider ?? value ?? '';
                kUserEmail = email;
              });
            },
            onValidate: (value) {
              return (value!.isEmpty ||
                      !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value))
                  ? 'Enter correct email'
                  : null;
            },
            hintText: 'Where do people email you?',
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email,
            labelText: 'Email *',
            initialValue: emailListenProvider ?? kUserEmail ?? '',
            obsecureText: false,
          ),
          InputButton(
            onSave: (String? value) {
              setState(() {
                name = value;
                kUserPassword = value;
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
            hintText: 'What do people call you?',
            keyboardType: TextInputType.name,
            icon: Icons.password,
            labelText: 'Password *',
            initialValue: kUserPassword ?? inputPass ?? '',
            obsecureText: true,
          ),
          InputButton(
            onSave: (String? value) {
              setState(() {
                phone = value;
                kUserPhone = value;
              });
            },
            onValidate: (value) {
              return (value!.isEmpty ||
                      !RegExp(r'^[6-9]\d{9}$').hasMatch(value))
                  ? 'Enter correct number'
                  : null;
            },
            hintText: 'Phone Number',
            keyboardType: TextInputType.number,
            icon: Icons.phone,
            labelText: 'Phone *',
            initialValue: '',
            obsecureText: false,
          ),
          InputButton(
            onSave: (String? value) {
              setState(() {
                nickname = value;
                kUserNickName = value;
              });
            },
            onValidate: (value) {
              return (value!.isEmpty ? 'Nickname cannot be empty' : null);
            },
            hintText: 'Your Nickname?',
            keyboardType: TextInputType.name,
            icon: Icons.person_add_alt,
            labelText: 'Pet Name *',
            initialValue: '',
            obsecureText: false,
          ),
          CustomElevatedButton(
            icon: const Icon(
              Icons.accessibility,
              color: Colors.black,
            ),
            myFunc: () {
              var dataCollected = {
                "name": kUserName,
                "password": kUserPassword ?? '',
                "email": kUserEmail,
                "nickname": kUserNickName,
                "phone": kUserPhone,
                "photoUrl": kUserPhotoUrl,
              };

              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                if (writeData(kUserEmail, dataCollected) != false) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  kSnackBarNotify(context, "Registering...");
                  Navigator.pushNamed(context, HomeScreen.id);
                }
              }
            },
            myText: 'Submit',
          ),
        ],
      ),
    );
  }
}

writeData(key, value) {
  try {
    myHiveBox.put(key, value);
  } catch (err) {
    return false;
  }
}

readData(key) {
  return myHiveBox.get(key);
}

void deleteData(key) {
  myHiveBox.delete(key);
}

getPassByKey(key) {
  dynamic data = myHiveBox.get(key);
  return data['password'];
}
getPhotoByKey(key) {
  dynamic data = myHiveBox.get(key);
  return data['photoUrl'];
}

class InputButton extends StatelessWidget {
  InputButton(
      {required this.onSave,
      required this.onValidate,
      required this.hintText,
      required this.keyboardType,
      required this.icon,
      required this.labelText,
      required this.initialValue,
      required this.obsecureText});
  final Function(String?) onSave;
  final String? Function(String?) onValidate;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final IconData icon;
  final String initialValue;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextFormField(
            // autovalidateMode: AutovalidateMode.always,
            obscureText: obsecureText,
            cursorColor: Colors.deepOrange,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              labelText: labelText,
            ),
            initialValue: initialValue,
            onSaved: onSave,
            validator: onValidate,
          ),
        ),
      ),
    );
  }
}
