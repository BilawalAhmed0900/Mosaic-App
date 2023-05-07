import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/Scaffolds/sign_in_scaffold.dart';
import 'package:mosaic_app/Scaffolds/sign_up_scaffold.dart';

class WelcomeBackScaffold extends StatelessWidget {
  const WelcomeBackScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset(
                        "assets/images/welcome_back_page_background.png")
                    .image,
                fit: BoxFit.fill),
          ),
          child: Stack(
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.22),
                        Colors.black.withOpacity(0.88)
                      ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.00862),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svgs/mini_logo_white.svg",
                          width: width * 0.127,
                          height: height * 0.0443,
                          theme: const SvgTheme(currentColor: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.0295,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * height * 0.0000525),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.00492,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Set a stance to",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * height * 0.0000919,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "change the world!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * height * 0.0000919,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.0603,
                    ),
                    SizedBox(
                      width: width * 0.818,
                      height: height * 0.0665,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const SignInScaffold();
                          }));
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                        ),
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * height * 0.0000591,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.0123,
                    ),
                    SizedBox(
                      width: width * 0.818,
                      height: height * 0.0665,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                        ),
                        child: Text(
                          "Sign in as guest",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * height * 0.0000591,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.0307,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: const Color(0x54FFFFFF),
                              fontSize: width * height * 0.0000426),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const SignUpScaffold();
                            }));
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * height * 0.0000426,
                            ),
                          ),
                        )
                      ],
                    )
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
