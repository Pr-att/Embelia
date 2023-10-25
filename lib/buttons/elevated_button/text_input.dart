import 'package:embelia/authentication/user_auth.dart';
import 'package:flutter/material.dart';

class InputTextButton extends StatefulWidget {
  static const id = "InputTextButton";
  const InputTextButton({super.key});

  @override
  State<InputTextButton> createState() => _InputTextButtonState();
}

class _InputTextButtonState extends State<InputTextButton> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            controller: _nameController,
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
            controller: _emailController,
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
            controller: _passwordController,
            hintText: 'Enter your password',
            keyboardType: TextInputType.name,
            icon: Icons.password,
            labelText: 'Password *',
            obsecureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await UserAuth().signInUsingEmailPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context,
                  name: _nameController.text,
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class InputButton extends StatefulWidget {
  const InputButton(
      {super.key,
      required this.onValidate,
      required this.hintText,
      required this.keyboardType,
      required this.icon,
      required this.labelText,
      required this.obsecureText,
      required this.controller});
  final String? Function(String?) onValidate;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final IconData icon;
  final bool obsecureText;
  final TextEditingController controller;

  @override
  State<InputButton> createState() => _InputButtonState();
}

class _InputButtonState extends State<InputButton> {
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
            controller: widget.controller,
            obscureText: widget.obsecureText,
            cursorColor: Colors.deepOrange,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              labelText: widget.labelText,
            ),
            // onSaved: onSave,
            validator: widget.onValidate,
          ),
        ),
      ),
    );
  }
}
