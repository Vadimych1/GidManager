import 'dart:async';
import 'package:gid_manager/view/uikit.dart';
import 'package:flutter/material.dart';
import 'package:gid_manager/logic/lg_server.dart';
import 'package:gid_manager/classes/cl_homepage_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Server s = Server();

  List<Town> towns = <Town>[];
  List<Town> likedTowns = <Town>[];
  List<Place> likedPlaces = <Place>[];

  late Timer timer;
  late TabController controller;
  late TabController favController;

  List<Widget> appbarTop = <Widget>[
    const Text("Главная"),
    const Text("Избранное"),
    const Text("Настройки"),
  ];
  var currentAppbarTop = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 3,
      vsync: this,
    );
    favController = TabController(
      length: 2,
      vsync: this,
    );

    s.getTowns().then((value) {
      setState(() {
        towns = value.data;
      });
    });
    timer = Timer.periodic(const Duration(seconds: 30), (t) {
      // s.getTowns().then((value) {
      //   setState(() {
      //     towns = value.data;
      //   });
      // });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(towns);
    return Container(
      color: const Color(0xFFFFFFFF),
      child: SafeArea(
        minimum: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: TabBar(
            onTap: (i) {
              currentAppbarTop = i;
              setState(() {});
            },
            dividerHeight: 0,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            controller: controller,
            labelStyle: const TextStyle(fontSize: 13),
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                text: "Главная",
                iconMargin: EdgeInsets.zero,
              ),
              Tab(
                icon: Icon(
                  Icons.favorite,
                  size: 20,
                ),
                text: "Избранное",
                iconMargin: EdgeInsets.zero,
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  size: 20,
                ),
                text: "Настройки",
                iconMargin: EdgeInsets.zero,
              ),
            ],
          ),
          appBar: AppBar(
            title: appbarTop[currentAppbarTop],
            surfaceTintColor: Colors.transparent,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // TODO: open settings
              },
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: towns.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: towns.isEmpty
                      ? [const Text("Загрузка...")]
                      : [for (Town town in towns) TownBlock(town)],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: towns.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    TabBar.secondary(
                      tabs: const [
                        Tab(
                          icon: Icon(Icons.fax),
                          text: "Города",
                        ),
                        Tab(
                          icon: Icon(Icons.manage_search_sharp),
                          text: "Места",
                        )
                      ],
                      controller: favController,
                    ),
                    TabBarView(
                      controller: favController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              for (Place place in likedPlaces) Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
