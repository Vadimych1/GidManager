import 'package:flutter/material.dart';
import '../uikit.dart';
import "../../logic/lg_validators.dart";

class RegisterStep1 extends StatefulWidget {
  const RegisterStep1({super.key});

  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  bool valid = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texts
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Регистрация",
                    style: TextStyle(
                      fontSize: 36,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Text(
                    "Зарегистрируйтесь, чтобы продолжить",
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
                      Navigator.of(context).pushReplacementNamed("/login");
                    },
                    child: const Text(
                      "Вход",
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
                        Navigator.of(context).pushNamed("/register/step2");
                      }
                    },
                    child: const Text(
                      "Далее",
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
