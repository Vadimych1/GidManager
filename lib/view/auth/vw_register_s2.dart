import 'package:flutter/material.dart';
import '../uikit.dart';
import "../../logic/lg_validators.dart";

class RegisterStep2 extends StatefulWidget {
  const RegisterStep2({super.key});

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
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
                    "Введите данные",
                    style: TextStyle(
                      fontSize: 36,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Text(
                    "Последний шаг, и всё готово!",
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
                    placeholder: "Иван",
                    label: "Ваше имя",
                    name: "name",
                    keyboardType: TextInputType.name,
                    validator: notEmptyValidator,
                  ),
                  FormInputName(
                    placeholder: "00.00.0000",
                    label: "Дата рождения",
                    name: "birth",
                    keyboardType: TextInputType.datetime,
                    validator: dateValidator,
                  ),
                ],
                popOnSubmit: false,
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
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Назад",
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
                        // TODO: send request and navigate
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
