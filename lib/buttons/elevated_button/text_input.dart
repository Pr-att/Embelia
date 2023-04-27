import 'package:embelia/authentication/user_auth.dart';
import 'package:embelia/screens/home_screen.dart';
import 'package:embelia/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../authentication/user_data.dart';



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

    var nameListenProvider = context.watch<UserAuth>().name;
    var emailListenProvider = context.watch<UserAuth>().tempGoogleIDEmail;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputButton(
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
            obsecureText: false,
          ),
          InputButton(
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
            obsecureText: false,
          ),
          InputButton(
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
            obsecureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Processing Data'),
                  ),
                );
                Provider.of<UserAuth>(context, listen: false)
                    .signInWithGoogle();
                Navigator.pushNamed(context, HomeScreen.id);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

writeData(key, value) {
  try {
    // myHiveBox.put(key, value);
  } catch (err) {
    return false;
  }
}

readData(key) {
  // return myHiveBox.get(key);
}

void deleteData(key) {
  // myHiveBox.delete(key);
}

getPassByKey(key) {
  // dynamic data = myHiveBox.get(key);
  // return data['password'];
}
getPhotoByKey(key) {
  // dynamic data = myHiveBox.get(key);
  // return data['photoUrl'];
}

class InputButton extends StatelessWidget {
  InputButton(
      // {required this.onSave,
          {super.key,
      required this.onValidate,
      required this.hintText,
      required this.keyboardType,
      required this.icon,
      required this.labelText,
      required this.obsecureText});
  // final Function(String?) onSave;
  final String? Function(String?) onValidate;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final IconData icon;
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
            // onSaved: onSave,
            validator: onValidate,
          ),
        ),
      ),
    );
  }
}
