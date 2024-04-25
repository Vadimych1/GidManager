import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gid_manager/classes/cl_homepage_data.dart';
import 'package:url_launcher/url_launcher.dart';

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

    controller = TabController(length: widget.places.length + 2, vsync: this);
  }

  String tryDecodeLink(String l) {
    try {
      return Uri.decodeFull(l);
    } catch (e) {
      return l;
    }
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ? width fix
                        SizedBox(width: MediaQuery.of(context).size.width),

                        // ? Title
                        Text(
                          widget.places[i].description.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // ? Image
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            widget.places[i].imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ? Subtitle
                        const Text("Оценка пользователей",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),

                        // ? Rating
                        Row(
                          children: [
                            for (var _ in [
                              for (var ir = 0;
                                  ir < widget.places[i].stars;
                                  ir++)
                                0
                            ])
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 24,
                              ),
                            for (var _ in [
                              for (var ir = 0;
                                  ir < 5 - widget.places[i].stars;
                                  ir++)
                                0
                            ])
                              const Icon(
                                Icons.star_outline,
                                color: Colors.yellow,
                                size: 24,
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // ? Subtitle
                        const Text(
                          "Немного о достопримечательности",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // ? Paragraphs
                        for (var t
                            in widget.places[i].description.paragraphs) ...[
                          Text(
                            t,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                        const SizedBox(height: 20),

                        // ? Subtitle
                        const Text(
                          "Ссылки на источники",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        // ? Links
                        for (var t in widget.places[i].description.links)
                          InkWell(
                            onTap: () {
                              try {
                                launchUrl(
                                  Uri.tryParse(t) ??
                                      Uri.tryParse("https://$t") ??
                                      Uri.https("google.com"),
                                );
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                            },
                            child: Text(
                              tryDecodeLink(t),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        const SizedBox(height: 40),

                        // ? Buttons
                        Row(
                          children: [
                            TextButton(
                              child: const Text("Назад"),
                              onPressed: () {
                                controller.animateTo(controller.index - 1);
                              },
                            ),
                            TextButton(
                              child: const Text("Далее"),
                              onPressed: () {
                                controller.animateTo(controller.index + 1);
                              },
                            ),
                          ],
                        ),
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
