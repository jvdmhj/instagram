import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackGroundColor,
        centerTitle: false,
        title: Image.asset(
          'lib/assets/images/ic_instagram.svg',
          color: primaryColor,
          height: 35,
        ),
        actions: [],
      ),
    );
  }
}
