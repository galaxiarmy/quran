import 'package:alquran/app/contants/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Al-Quran'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.SEARCH);
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Assalamualaikum",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Wahai Muslimin"),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [appGreenLight2, appGreenDark]),
                      borderRadius: BorderRadius.circular(20)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.LAST_READ);
                      },
                      child: Container(
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: -30,
                                right: 0,
                                child: Opacity(
                                  opacity: 0.6,
                                  child: Container(
                                      width: 200,
                                      height: 200,
                                      child: Image.asset(
                                        "assets/images/icon_quran.png",
                                        fit: BoxFit.contain,
                                      )),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: appWhite,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Terakhir di baca",
                                        style: TextStyle(color: appWhite),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Al-Fatihah",
                                    style: TextStyle(
                                        color: appWhite, fontSize: 20),
                                  ),
                                  Text(
                                    "Juz 1 | Ayat 7",
                                    style: TextStyle(
                                        color: appWhite, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        // decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //         colors: [appGreenLight2, appGreenDark]),
                        //     borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ),
                TabBar(
                    indicatorColor: appGreenDark,
                    labelColor: Get.isDarkMode ? appWhite : appGreenDark,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        text: "Surah",
                      ),
                      Tab(
                        text: "Juz",
                      ),
                      Tab(
                        text: "Bookmark",
                      ),
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    FutureBuilder<List<Surah>>(
                        future: controller.getAllSurah(),
                        builder: (context, snapshoot) {
                          if (snapshoot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshoot.hasData) {
                            return Center(
                              child: (Text("Tidak ada Data!")),
                            );
                          }
                          // print(snapshoot.data);
                          return ListView.builder(
                              itemCount: snapshoot.data!.length,
                              itemBuilder: (context, index) {
                                Surah surah = snapshoot.data![index];
                                return ListTile(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_SURAH,
                                        arguments: surah);
                                  },
                                  leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Get.isDarkMode
                                                ? "assets/images/octagonal_logo_dark.png"
                                                : "assets/images/octagonal_logo.png"))),
                                    child: Center(
                                      child: Text(
                                        "${surah.number}",
                                        style: TextStyle(
                                            color: Get.isDarkMode
                                                ? appWhite
                                                : appGreenDark),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "Surah ${surah.name?.transliteration!.id ?? "Error"}",
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? appWhite
                                            : appGreenDark),
                                  ),
                                  subtitle: Text(
                                      "${surah.numberOfVerses} Ayat | ${surah.revelation!.id ?? "Error.."}"),
                                  trailing: Text(
                                      "${surah.name!.short ?? "Error.."}",
                                      style: TextStyle(color: appGreenDark)),
                                );
                              });
                        }),
                    ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {},
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Get.isDarkMode
                                        ? "assets/images/octagonal_logo_dark.png"
                                        : "assets/images/octagonal_logo.png"))),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? appWhite
                                        : appGreenDark),
                              ),
                            ),
                          ),
                          title: Text(
                            "Juz ${index + 1}",
                            style: TextStyle(
                                color:
                                    Get.isDarkMode ? appWhite : appGreenDark),
                          ),
                        );
                      },
                    ),
                    Center(child: Text("Text 3"))
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
