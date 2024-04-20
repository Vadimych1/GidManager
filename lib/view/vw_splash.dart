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
          children: [
            // TODO: logo
            Text(
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
