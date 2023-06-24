import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/Scaffolds/tips_page_2_scaffold.dart';

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
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.only(left: width * 0.464, right: width * 0.064),
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
                height: height * 0.033,
              ),
              Stack(
                children: [
                  Image.asset(
                    "assets/images/tip_page_1_background.png",
                    width: width,
                    height: height * 0.562,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.467),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Experience",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * height * 9.195e-5),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "unique perspective",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * height * 9.195e-5),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "on breaking news",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * height * 9.195e-5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.012),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mosaic is a short video platform offering",
                    style: TextStyle(fontSize: width * height * 4.926e-5),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "unique perspectives on breaking news",
                    style: TextStyle(fontSize: width * height * 4.926e-5),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "and trending topics through user-",
                    style: TextStyle(fontSize: width * height * 4.926e-5),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "generated content",
                    style: TextStyle(fontSize: width * height * 4.926e-5),
                  ),
                ],
              ),
              SizedBox(height: height * 0.046),
              SizedBox(
                width: width * 0.914,
                height: height * 0.0665,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const TipsPage2Scaffold();
                    }));
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48),
                    ),
                  ),
                  child: Text(
                    "Next",
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
