import 'dart:io';
import 'package:embelia/authentication/auth_user.dart';
import 'package:embelia/buttons/elevated_button/text_input.dart';
import 'package:embelia/constants.dart';
import 'package:embelia/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../authentication/user_data_constants.dart';

class RegistrationScreen extends StatefulWidget with ChangeNotifier {
  static const String id = "RegistrationScreen";
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

Future pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    final tempImage = File(image.path);
    return tempImage;
  } on PlatformException catch (e) {
    print(e);
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenHeight = MediaQuery.of(context).size.height;
    ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xff03071e), Color(0xff034445)],
              ),
            ),
          ),
          actions: []),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 70,
                            child: CircleAvatar(
                              radius: 67,
                              backgroundImage: userImageUrl == null &&
                                      context
                                              .watch<UserAuth>()
                                              .userPhotoUrl ==
                                          null
                                  ? Image.asset("assets/asset/user.png").image
                                  : userImageUrl != null
                                      ? Image.file(userImageUrl).image
                                      : Image.network(context
                                              .watch<UserAuth>()
                                              .userPhotoUrl)
                                          .image,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenWidth * 0.25,
                                left: ScreenHeight * 0.1),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[900],
                              child: IconButton(
                                onPressed: (() async {
                                  var userUrl = await pickImage();
                                  if (userUrl != null) {
                                  setState(() {
                                    userImageUrl = userUrl;
                                    kUserPhotoUrl = userUrl;
                                  });
                                  // enter snackbar widget here
                                  kSnackBarNotify(context, 'Updating..'); }
                                }),
                                icon: const FaIcon(FontAwesomeIcons.camera),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: ScreenWidth * 0.1),
                        child: Container(),
                      ),
                    ],
                  ),
                  const InputTextButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
