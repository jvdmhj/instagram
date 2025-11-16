import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/resources/auth_methodes.dart';
import 'package:instagram/responsive/screens/signup_page.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widget/text_field_input.dart';
import 'package:instagram/responsive/mobilescreenlayout.dart';
import 'package:instagram/responsive/webscreenlayout.dart';
import 'package:instagram/responsive/responsive_layout_screens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginButton() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMetodes().loginUsers(
      email: emailController.text,
      password: passwordController.text,
    );
    if (res == 'success') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      isLoading = false;
    });
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
              TextFieldInput(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                hibtText: 'Enter your email',
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                controller: passwordController,
                textInputType: TextInputType.emailAddress,
                hibtText: 'Enter your password',
                isPass: true,
              ),
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: loginButton,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : Text('log in'),
                ),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(child: Container(), flex: 2),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SigninPage()),
                      ),
                      child: Text('Don"t have an account?'),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      ),
                      child: Text(
                        'Log in.',
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
