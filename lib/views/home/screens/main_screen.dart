import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/core/widgets/menu.dart';
import 'package:king_movie/viewmodels/home_viewmodel.dart';
import 'package:king_movie/views/home/screens/search_screen.dart';
import 'package:king_movie/views/home/widgets/advance_search_dialog.dart';
import 'package:king_movie/views/home/widgets/new_movie_widget.dart';
import 'package:king_movie/views/movie_detail/screens/movie_detail_screen.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, this.isLogedIn = false});
  final bool isLogedIn;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeViewModel());
    if (isLogedIn) controller.getData();

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blackColor,
      appBar: homeAppBar(context: context),
      drawer: const Menu(),
      body: controller.obx(
        (status) =>
            ListView(controller: controller.mainScrollController, children: [
          // search text form field
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height / 20, horizontal: Get.width / 20),
            child: InkWell(
              onTap: () => controller.searchFocusNode.requestFocus(),
              child: SizedBox(
                width: Get.width,
                height: Get.height / 15,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.bottom,
                    onChanged: (value) => controller.searchValue = value,
                    focusNode: controller.searchFocusNode,
                    onFieldSubmitted: (_) => Get.to(() => SearchScreen(
                          title: controller.searchValue,
                        )),
                    decoration: InputDecoration(
                        filled: true,
                        suffixIcon: Row(
                          // mainAxisAlignment:
                          // MainAxisAlignment.spaceBetween, // added line
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () => Get.dialog(AdvanceSearchDialog(
                                model: controller.homeModel,
                              )),
                              child: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () => Get.to(() => SearchScreen(
                                    title: controller.searchValue,
                                  )),
                              child: const Icon(
                                Icons.search,
                                color: yellowColor,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                        hintStyle: const TextStyle(
                            color: Color(0xffafafaf), fontSize: 12),
                        fillColor: textFormColor,
                        hintText: "فیلم و سریال را جست وجوی کنید",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
            ),
          ),

          // banners
          SizedBox(
            width: Get.width,
            height: Get.height / 2.5,
            child: ListView.builder(
                itemCount: controller.homeModel?.data?.slider?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => InkWell(
                    onTap: () => Get.to(() => MovieDetailScreen(
                          movieId:
                              controller.homeModel?.data?.slider?[index].id ??
                                  "",
                        )),
                    child: Container(
                      width: Get.width / 6.5,
                      height: Get.height,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(controller
                                      .homeModel?.data?.slider?[index].poster ??
                                  ""))),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: Get.width,
                        height: Get.height / 12,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromRGBO(0, 0, 0, 0.3),
                          Color.fromRGBO(0, 0, 0, 0.1),
                        ])),
                        alignment: Alignment.center,
                        child: Text(
                          controller.homeModel?.data?.slider?[index].title ??
                              "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  12 * MediaQuery.of(context).textScaleFactor),
                        ),
                      ),
                    ))),
          ),
          SizedBox(
            height: Get.height / 20,
          ),

          // new series
          AutoScrollTag(
            controller: controller.mainScrollController,
            key: const ValueKey(4),
            index: 4,
            child: Container(
                width: Get.width,
                height: Get.height / 2.1,
                color: darkBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "سریال های بروز شده",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount:
                                controller.homeModel?.data?.series?.length ?? 0,
                            controller: controller.newSeriesController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => AutoScrollTag(
                                  controller: controller.newSeriesController,
                                  key: ValueKey(index),
                                  index: index,
                                  highlightColor: Colors.green,
                                  child: NewMovieWidget(
                                    model: controller
                                        .homeModel?.data?.series?[index]
                                        .toWidgetModel(),
                                    onFocus: (isFocus) {
                                      if (isFocus) {
                                        if (controller.mainScrollIndex != 4) {
                                          controller.mainScrollIndex = 4;
                                          controller.mainScrollController
                                              .scrollToIndex(4,
                                                  duration: const Duration(
                                                      milliseconds: 300));
                                        }
                                        controller.newSeriesController
                                            .scrollToIndex(index,
                                                duration: const Duration(
                                                    milliseconds: 300));
                                      }
                                    },
                                  ),
                                )))
                  ],
                )),
          ),

          // new movies
          AutoScrollTag(
            controller: controller.mainScrollController,
            key: const ValueKey(5),
            index: 5,
            child: Container(
                width: Get.width,
                height: Get.height / 2.1,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: darkBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "فیلم های بروز شده",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount:
                                controller.homeModel?.data?.series?.length ?? 0,
                            controller: controller.newMoviesController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => AutoScrollTag(
                                  controller: controller.newMoviesController,
                                  key: ValueKey(index),
                                  index: index,
                                  highlightColor: Colors.green,
                                  child: NewMovieWidget(
                                    model: controller
                                        .homeModel?.data?.movie?[index]
                                        .toWidgetModel(),
                                    onFocus: (isFocus) {
                                      if (isFocus) {
                                        if (controller.mainScrollIndex != 5) {
                                          controller.mainScrollIndex = 5;
                                          controller.mainScrollController
                                              .scrollToIndex(5,
                                                  duration: const Duration(
                                                      milliseconds: 300));
                                        }
                                        controller.newMoviesController
                                            .scrollToIndex(index,
                                                duration: const Duration(
                                                    milliseconds: 300));
                                      }
                                    },
                                  ),
                                )))
                  ],
                )),
          ),

          // box office
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "\tباکس آفیس",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17 * MediaQuery.of(context).textScaleFactor),
            ),
          ),
          SizedBox(
              width: Get.width,
              height: Get.height / 3,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.homeModel?.data?.slider?.length ?? 0,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () => Get.to(() => MovieDetailScreen(
                            movieId:
                                controller.homeModel?.data?.box?[index].id ??
                                    "",
                          )),
                      child: Container(
                        width: Get.width / 5.5,
                        height: Get.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(controller
                                        .homeModel?.data?.box?[index].poster ??
                                    ''))),
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: yellowColor,
                          child: Center(
                              child: Text(controller
                                      .homeModel?.data?.box?[index].number
                                      .toString() ??
                                  '')),
                        ),
                      )))),

          // Time line
          /*
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
                width: Get.width,
                height: Get.height / 6.6,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "شنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[0].month.toString().toPersianDigit()}/${daysList[0].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "یکشنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[1].month.toString().toPersianDigit()}/${daysList[1].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "دوشنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[2].month.toString().toPersianDigit()}/${daysList[2].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "سه شنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[3].month.toString().toPersianDigit()}/${daysList[3].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "چهارشنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[4].month.toString().toPersianDigit()}/${daysList[4].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "پنجشنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[5].month.toString().toPersianDigit()}/${daysList[5].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "جمعه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[6].month.toString().toPersianDigit()}/${daysList[6].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                )),
          ),

          // time line widgets
          
          SizedBox(
            height: Get.height / 35,
          ),
          Column(
            children: List.generate(
                4,
                (index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      width: Get.width,
                      height: Get.height / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: darkBlue,
                      ),
                      child: Row(textDirection: TextDirection.ltr, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "1. Elemental | المنتال",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                            Row(
                              textDirection: TextDirection.ltr,
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: yellowColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("07:29",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15 *
                                            MediaQuery.of(context)
                                                .textScaleFactor))
                              ],
                            )
                          ],
                        )),
                        Padding(
                            padding: EdgeInsets.only(right: Get.width / 25),
                            child: const Text("فصل 2 قسمت 4",
                                style: TextStyle(
                                  color: Colors.white,
                                )))
                      ]),
                    )),
          ),
*/
          SizedBox(
            height: Get.height / 35,
          ),

          // new dub series
          AutoScrollTag(
            controller: controller.mainScrollController,
            key: const ValueKey(6),
            index: 6,
            child: Container(
                width: Get.width,
                height: Get.height / 2.1,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: darkBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "سریال های دوبله بروز شده",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount:
                                controller.homeModel?.data?.series?.length ?? 0,
                            controller: controller.newDubSeriesController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => AutoScrollTag(
                                  controller: controller.newDubSeriesController,
                                  key: ValueKey(index),
                                  index: index,
                                  highlightColor: Colors.green,
                                  child: NewMovieWidget(
                                    model: controller
                                        .homeModel?.data?.seriesDouble?[index]
                                        .toWidgetModel(),
                                    onFocus: (isFocus) {
                                      if (isFocus) {
                                        if (controller.mainScrollIndex != 6) {
                                          controller.mainScrollIndex = 6;
                                          controller.mainScrollController
                                              .scrollToIndex(6,
                                                  duration: const Duration(
                                                      milliseconds: 300));
                                        }
                                        controller.newDubSeriesController
                                            .scrollToIndex(index,
                                                duration: const Duration(
                                                    milliseconds: 300));
                                      }
                                    },
                                  ),
                                )))
                  ],
                )),
          ),

          // new dub movies
          AutoScrollTag(
            controller: controller.mainScrollController,
            key: const ValueKey(7),
            index: 7,
            child: Container(
                width: Get.width,
                height: Get.height / 2.1,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: darkBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "فیلم های دوبله بروز شده",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount:
                                controller.homeModel?.data?.series?.length ?? 0,
                            controller: controller.newDubMoviesController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => AutoScrollTag(
                                  controller: controller.newDubMoviesController,
                                  key: ValueKey(index),
                                  index: index,
                                  highlightColor: Colors.green,
                                  child: NewMovieWidget(
                                    model: controller
                                        .homeModel?.data?.movieDouble?[index]
                                        .toWidgetModel(),
                                    onFocus: (isFocus) {
                                      if (isFocus) {
                                        if (controller.mainScrollIndex != 7) {
                                          controller.mainScrollIndex = 7;
                                          controller.mainScrollController
                                              .scrollToIndex(7,
                                                  duration: const Duration(
                                                      milliseconds: 300));
                                        }
                                        controller.newDubMoviesController
                                            .scrollToIndex(index,
                                                duration: const Duration(
                                                    milliseconds: 300));
                                      }
                                    },
                                  ),
                                )))
                  ],
                )),
          ),

          SizedBox(
            height: Get.height / 25,
          )
        ]),
      ),
    ));
  }
}
