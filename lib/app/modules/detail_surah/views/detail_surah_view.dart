import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'SURAH ${surah.name?.transliteration?.id?.toUpperCase() ?? "Error.."}'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${surah.name?.transliteration?.id?.toUpperCase() ?? "Error.."}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "(${surah.name?.translation?.id?.toUpperCase() ?? "Error.."})",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${surah.numberOfVerses ?? "Error.."} Ayat | ${surah.revelation?.id}",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<detail.DetailSurah>(
                future: controller.getDetailSurah(surah.number.toString()),
                builder: (context, snapshoot) {
                  if (snapshoot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshoot.hasData) {
                    return Center(
                      child: (Text("Tidak ada Data!")),
                    );
                  }

                  print(snapshoot);

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshoot.data?.verses?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (snapshoot.data?.verses?.length == 0) {
                          return SizedBox();
                        }

                        detail.Verse? ayat = snapshoot.data?.verses?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Text("${index + 1}"),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.bookmark_add_outlined)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.play_arrow)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "${ayat!.text?.arab}",
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${ayat.translation?.id}",
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        );
                      });
                }),
          ],
        ));
  }
}
