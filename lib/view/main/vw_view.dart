// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gid_manager/classes/cl_homepage_data.dart';

class View extends StatefulWidget {
  const View({super.key, required this.places, required this.town});

  final List<Place> places;
  final String town;

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          bottom: TabBar(
            controller: controller,
            tabs: [
              const Tab(
                icon: Icon(Icons.exit_to_app),
              ),
              for (var i = 0; i < widget.places.length; i++)
                Tab(
                  text: "${i + 1}",
                ),
              const Tab(
                icon: Icon(Icons.check),
              ),
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            controller: controller,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 20, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Привет! Это ",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: widget.town,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Нажми кнопку ниже, чтобы начать виртуальный тур. Ты также можешь переключаться между вкладками с помощью слайдера сверху.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        TextButton(
                          child: Text("Назад"),
                          onPressed: Navigator.of(context).pop,
                        ),
                        TextButton(
                          child: Text("Начать"),
                          onPressed: () {
                            controller.animateTo(1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              for (var i = 0; i < widget.places.length; i++)
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 20,
                    top: 15,
                  ),
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        // TODO: VIEW PLACE

                        // NAME

                        // IMAGE

                        // ABOUT BLOCK 1

                        // ABOUT BLOCK 2

                        // LINKS
                      ],
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 20, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Тур завершен!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Понравился город ${widget.town}?",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        TextButton(
                          onPressed: Navigator.of(context).pop,
                          child: const Text("Закрыть"),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.animateTo(0);
                          },
                          child: const Text("Заново"),
                        ),
                      ],
                    ),
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
