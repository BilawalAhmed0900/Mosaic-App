import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/Scaffolds/watch_page_scaffold.dart';

class NewPostPublishedScaffold extends StatelessWidget {
  final Map<String, dynamic> post;

  const NewPostPublishedScaffold({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: height * 0.054),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 1,),
              Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: width * height * 1.379e-4,
                            backgroundColor: const Color(0xFFC6FFC5),
                            child: Icon(
                              Icons.check,
                              size: width * height * 9.852e-5,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.037),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Success!",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * height * 9.195e-5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Stance published successfully",
                        style: TextStyle(fontSize: width * height * 5.255e-5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "share it with anyone now.",
                        style: TextStyle(fontSize: width * height * 5.255e-5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.037,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.224),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "assets/svgs/facebook-icon.svg",
                          width: min(width * 0.096, height * 0.044),
                          height: min(width * 0.096, height * 0.044),
                        ),
                        SvgPicture.asset(
                          "assets/svgs/facebook-icon.svg",
                          width: min(width * 0.096, height * 0.044),
                          height: min(width * 0.096, height * 0.044),
                        ),
                        SvgPicture.asset(
                          "assets/svgs/facebook-icon.svg",
                          width: min(width * 0.096, height * 0.044),
                          height: min(width * 0.096, height * 0.044),
                        ),
                        SvgPicture.asset(
                          "assets/svgs/facebook-icon.svg",
                          width: min(width * 0.096, height * 0.044),
                          height: min(width * 0.096, height * 0.044),
                        ),
                        CircleAvatar(
                          radius: width * height * 5.911e-5,
                          backgroundColor: const Color(0xFFF5F5F5),
                          child: Icon(
                            Icons.copy,
                            color: const Color(0xFF979797),
                            size: width * height * 6.897e-5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.914,
                height: height * 0.0665,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return const WatchVideoScaffold();
                    }));
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48),
                    ),
                  ),
                  child: Text(
                    "Back to home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * height * 0.0000591,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
