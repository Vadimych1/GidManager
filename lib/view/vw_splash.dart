import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2, milliseconds: 500),
      () {
        Navigator.of(context).pushReplacementNamed("/login");
      },
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: logo
            Container(
              width: MediaQuery.of(context).size.width,
            ),
            const Text(
              "Gid Manager",
              style: TextStyle(
                fontSize: 46,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
