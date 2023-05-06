import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TipsPage1Scaffold extends StatelessWidget {
  const TipsPage1Scaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFFFDD9B),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.0771),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.5, right: width * 0.064),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/mini_logo.svg",
                      width: width * 0.0707,
                      height: height * 0.0257,
                      theme: const SvgTheme(currentColor: Colors.black),
                    ),
                    Text(
                      "1/3",
                      style: TextStyle(fontSize: width * height * 0.0000445),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.0424,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/TipsPage1Svg2.svg",
                        width: width * 0.586,
                        height: height * 0.564,
                        theme: const SvgTheme(currentColor: Colors.black),
                      ),
                      Container(
                        width: width * 0.586,
                        height: height * 0.564,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0,
                              0.5,
                              0.7,
                              0.8,
                              1
                            ],
                            colors: [
                              const Color(0xFFFFDD9B),
                              const Color(0xFFFFDD9B).withOpacity(0),
                              const Color(0xFFFFDD9B).withOpacity(0),
                              const Color(0xFFFFDD9B).withOpacity(0),
                              const Color(0xFFFFDD9B).withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
