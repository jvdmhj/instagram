import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methodes.dart';
import 'package:instagram/responsive/screens/login_page.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widget/text_field_input.dart';
import 'package:instagram/responsive/mobilescreenlayout.dart';
import 'package:instagram/responsive/webscreenlayout.dart';
import 'package:instagram/responsive/responsive_layout_screens.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  Uint8List? image;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void selectimage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMetodes().signUpUsers(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
      bio: bioController.text,
      file: image!,
    );
    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: SvgPicture.asset(
                  'lib/assets/images/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
              ),
              SizedBox(height: 64),
              Stack(
                children: [
                  image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/b/default-profile-picture-avatar-photo-placeholder-vector-illustration-default-profile-picture-avatar-photo-placeholder-vector-189495158.jpg',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectimage,
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                controller: usernameController,
                textInputType: TextInputType.text,
                hibtText: 'Enter your username',
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                hibtText: 'Enter your email',
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                hibtText: 'Enter your password',
                isPass: true,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                controller: bioController,
                textInputType: TextInputType.text,
                hibtText: 'Enter your bio',
              ),
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: InkWell(
                  onTap: signUpUser,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : Text('Sign up'),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(child: Container(), flex: 2),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      ),
                      child: Text(
                        'Already have an account.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
