import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../uikit.dart';
import "../../logic/lg_validators.dart";

class LoginStep1 extends StatefulWidget {
  const LoginStep1({super.key});

  @override
  State<LoginStep1> createState() => _LoginStep1State();
}

class _LoginStep1State extends State<LoginStep1> {
  bool valid = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // debug button
            kDebugMode
                ? ElevatedButton(
                    child: const Text("Debug Login"),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/home", (route) => false);
                    },
                  )
                : Container(),

            // Texts
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Вход",
                    style: TextStyle(
                      fontSize: 36,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Text(
                    "Войдите чтобы продолжить",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Inputs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomForm(
                validChanged: (b) {
                  setState(() {
                    valid = b;
                  });
                },
                inputs: [
                  FormInputName(
                    placeholder: "example@test.com",
                    label: "Почта",
                    name: "email",
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  FormInputName(
                    placeholder: "********",
                    label: "Пароль",
                    name: "password",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: passwordValidator,
                  ),
                ],
                popOnSubmit: false,
              ),
            ),

            // Forgot password
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    "Забыли пароль?",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      // TODO: send request
                    },
                    child: Text(
                      "Восстановить",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Button
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                        Color(0x00FFFFFF),
                      ),
                      foregroundColor: const MaterialStatePropertyAll<Color>(
                        Color(0xFF000000),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/register");
                    },
                    child: const Text(
                      "Регистрация",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        valid
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor,
                      ),
                      foregroundColor: const MaterialStatePropertyAll<Color>(
                        Color(0xFFFFFFFF),
                      ),
                    ),
                    onPressed: () {
                      if (valid) {
                        // Navigator.of(context).pushNamed("/login/step2"); // deprecated
                        // TODO: request + navigate to main page
                      }
                    },
                    child: const Text(
                      "Войти",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
