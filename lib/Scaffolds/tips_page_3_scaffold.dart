import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/Scaffolds/welcome_back_scaffold.dart';

class TipsPage3Scaffold extends StatelessWidget {
  const TipsPage3Scaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFC6FFC5),
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
                      "3/3",
                      style: TextStyle(fontSize: width * height * 0.0000445),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.185),
                    child: Image.asset(
                      "assets/images/tip_page_3_background.png",
                      width: width - width * 0.37,
                      height: height * 0.562,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.507),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Set your stance and", style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * height * 7.882e-5),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("and share with community", style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * height * 7.882e-5),),
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
                  Text("Coverage from local sources or ", style: TextStyle(fontSize: width * height * 4.926e-5),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("individuals who have direct experience ", style: TextStyle(fontSize: width * height * 4.926e-5),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("or knowledge of a particular event or ", style: TextStyle(fontSize: width * height * 4.926e-5),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("issue.", style: TextStyle(fontSize: width * height * 4.926e-5),),
                ],
              ),
              SizedBox(height: height * 0.098),
              SizedBox(
                width: width * 0.914,
                height: height * 0.0665,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return const WelcomeBackScaffold();
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
