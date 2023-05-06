import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/Scaffolds/tips_page_1.dart';

class SplashScreenPageScaffold extends StatelessWidget {
  const SplashScreenPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const TipsPage1Scaffold();
      }));
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFBBBBBB),
          child: Center(
            child: SvgPicture.asset("assets/svgs/logo.svg", width: width * 0.458, height: height * 0.0321, theme: const SvgTheme(currentColor: Colors.black),),
          ),
        ),
      ),
    );
  }
}

