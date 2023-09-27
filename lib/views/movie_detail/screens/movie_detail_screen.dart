import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/extensions/string_extension.dart';
import 'package:king_movie/core/widgets/trailer_widget.dart';
import 'package:king_movie/viewmodels/movie_viewmodel.dart';
import 'package:king_movie/views/home/screens/search_screen.dart';
import 'package:king_movie/views/login/screens/login_screen.dart';
import 'package:king_movie/views/login/screens/singup_screen.dart';
import 'package:king_movie/views/menu/screens/vip_screen.dart';
import 'package:king_movie/views/movie_detail/screens/play_movie_screen.dart';
import 'package:king_movie/views/movie_detail/widgets/comment_widget.dart';
import 'package:king_movie/views/movie_detail/widgets/series_tiles_widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.movieId});
  final String movieId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieViewModel(movieId));

    // RxInt starSelected = (-1).obs;
    RxInt openEexpansionIndex = (-1).obs;

    return WillPopScope(
      onWillPop: () async {
        controller.dispose();
        return true;
      },
      child: DefaultTabController(
          length: 5,
          child: Scaffold(
              backgroundColor: blackColor,
              body: controller.obx(
                (status) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width / 3.5,
                      height: Get.height / 1.5,
                      padding: const EdgeInsets.all(10),
                      // margin: EdgeInsets.only(bottom: Get.height / 5),
                      color: darkBlue,
                      child: Image.network(
                        controller.movieModel?.data?.poster ?? "",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                          controller: controller.pageScrollController,
                          cacheExtent: Get.height * 20,
                          children: [
                            // bottom of video
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              width: Get.width,
                              height: Get.height / 2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: darkBlue),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // title
                                    Text(
                                      controller.movieModel?.data?.title ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: const Color(0xffffffff),
                                          fontSize: 17 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    // score
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      textDirection: TextDirection.ltr,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            controller.movieModel?.data?.vote ??
                                                "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 18)),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                            controller
                                                    .movieModel?.data?.voter ??
                                                "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xffffffff),
                                            )),
                                      ],
                                    ),

                                    // give star
                                    /*
                                    Center(
                                      child: Column(
                                        children: [
                                          // const Text(
                                          //   "9.3 / 67",
                                          //   textDirection: TextDirection.ltr,
                                          //   style: TextStyle(
                                          //     color: Color(0xffffffff),
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              textDirection: TextDirection.ltr,
                                              children: List.generate(
                                                  10,
                                                  (index) => InkWell(
                                                        onTap: () => starSelected
                                                            .value = index,
                                                        child: Obx(() => Icon(
                                                              Icons.star,
                                                              color: index <=
                                                                      starSelected
                                                                          .value
                                                                  ? yellowColor
                                                                  : const Color(
                                                                      0xff5B6228),
                                                              size: Get.width / 20,
                                                            )),
                                                      )),
                                            ),
                                          ),
                                          Text(
                                            "به این فیلم امتیاز دهید",
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                color: const Color(0xffffffff),
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    */
                                    const Text(
                                      "خلاصه داستان : ",
                                      style: TextStyle(color: yellowColor),
                                    ),
                                    Text(
                                      controller.movieModel?.data?.story ?? "",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor),
                                    ),
                                    // tabs
                                    // Expanded(
                                    //     child: )
                                  ]),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                  5,
                                  (index) => InkWell(
                                      focusNode: index == 0
                                          ? controller.focusNode
                                          : null,
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            controller.pageScrollController
                                                .scrollToIndex(2,
                                                    duration: const Duration(
                                                        seconds: 1));
                                            break;
                                          case 1:
                                            controller.pageScrollController
                                                .scrollToIndex(4,
                                                    duration: Duration(
                                                        seconds: index))
                                                .then((value) => controller
                                                    .downloadFocus
                                                    .requestFocus());
                                            break;
                                          case 2:
                                            controller.pageScrollController
                                                .scrollToIndex(6,
                                                    duration: Duration(
                                                        seconds: index))
                                                .then((value) => controller
                                                    .castFocus
                                                    .requestFocus());
                                            break;
                                          case 3:
                                            controller.pageScrollController
                                                .scrollToIndex(8,
                                                    duration: Duration(
                                                        seconds: index))
                                                .then((value) => controller
                                                    .commentFocus
                                                    .requestFocus());
                                            break;
                                          case 4:
                                            controller.pageScrollController
                                                .scrollToIndex(10,
                                                    duration: const Duration(
                                                        seconds: 3));
                                            break;
                                        }
                                      },
                                      child: Text(
                                        [
                                          "توضیحات",
                                          "دانلود",
                                          "عوامل",
                                          "نظرات",
                                          "تریلر"
                                        ][index],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ))),
                            ),

                            // description
                            AutoScrollTag(
                                key: const ValueKey(2),
                                controller: controller.pageScrollController,
                                index: 2,
                                child: Text(
                                  (controller.movieModel?.data?.text ?? "")
                                      .replaceAll('<br>', '\n')
                                      .replaceAll('&quot;', ''),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13 *
                                          MediaQuery.of(context)
                                              .textScaleFactor),
                                )),
                            Divider(
                              color: Colors.grey,
                              height: Get.height / 18,
                            ),

                            // downloads
                            AutoScrollTag(
                              key: const ValueKey(4),
                              controller: controller.pageScrollController,
                              index: 4,
                              child: SizedBox(
                                  child: SingleChildScrollView(
                                      child:
                                          (controller.movieModel?.data?.link
                                                      ?.data?.isEmpty ??
                                                  true)
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      SingletonClass.instance
                                                                  .user ==
                                                              null
                                                          ? "برای استفاده از خدمات ابتدا وارد اپ شوید\n"
                                                          : "برای پخش یا دانلود باید اشتراک خریداری کنید\n",
                                                      style: TextStyle(
                                                          fontSize: 17 *
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaleFactor,
                                                          color: Colors.white),
                                                    ),
                                                    SingletonClass.instance
                                                                .user ==
                                                            null
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                focusNode:
                                                                    controller
                                                                        .downloadFocus,
                                                                onTap: () =>
                                                                    Get.to(() =>
                                                                        const LoginScreen()),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(7),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      const Text(
                                                                    "وارد شوید",
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () =>
                                                                    Get.to(() =>
                                                                        const SingupScreen()),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(7),
                                                                  margin: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          10),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      const Text(
                                                                    "ثبت نام کنید",
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : InkWell(
                                                            focusNode: controller
                                                                .downloadFocus,
                                                            onTap: () => Get.to(
                                                                () =>
                                                                    const VipScreen()),
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(7),
                                                              margin: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: const Text(
                                                                "خرید اشتراک",
                                                                style:
                                                                    TextStyle(),
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                )
                                              : Column(
                                                  children: List.generate(
                                                    controller
                                                            .movieModel
                                                            ?.data
                                                            ?.link
                                                            ?.data
                                                            ?.length ??
                                                        0,
                                                    (index) => Column(
                                                        children: [
                                                          Container(
                                                            width: Get.width,
                                                            height:
                                                                Get.height / 12,
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    Get.height /
                                                                        18),
                                                            color: controller
                                                                .movieModel
                                                                ?.data
                                                                ?.link
                                                                ?.data?[index]
                                                                .color
                                                                .downloadColor(),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  controller
                                                                          .movieModel
                                                                          ?.data
                                                                          ?.link
                                                                          ?.data?[
                                                                              index]
                                                                          .title ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Text(
                                                                  controller
                                                                          .movieModel
                                                                          ?.data
                                                                          ?.link
                                                                          ?.data?[
                                                                              index]
                                                                          .des ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          controller
                                                                      .movieModel
                                                                      ?.data
                                                                      ?.way ==
                                                                  "1"
                                                              ? Column(
                                                                  children: List
                                                                      .generate(
                                                                          controller.movieModel?.data?.link?.data?[index].list?.length ??
                                                                              0,
                                                                          (secondIndex) =>
                                                                              ListTile(
                                                                                focusNode: index == 0 && secondIndex == 0 ? controller.downloadFocus : null,
                                                                                tileColor: controller.movieModel?.data?.link?.data?[index].color.downloadColor(),
                                                                                title: Text(
                                                                                  controller.movieModel?.data?.link?.data?[index].list?[secondIndex].title ?? "",
                                                                                  style: const TextStyle(color: Colors.white),
                                                                                ),
                                                                                onTap: () => Get.dialog(SeriesDialog(
                                                                                    downloadList: controller.movieModel?.data?.link?.data?[index].list?[secondIndex],
                                                                                    initVideo: (initVideo) =>initVideo==null?{}: Get.to(() => PlayMovieScreen(downloadList: initVideo)),
                                                                                    // controller
                                                                                    //     .choosePlayer(
                                                                                    //         initVideo),
                                                                                    download: (download) => controller.openUrl(download))),
                                                                              )))
                                                              : Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: List
                                                                      .generate(
                                                                    controller
                                                                            .movieModel
                                                                            ?.data
                                                                            ?.link
                                                                            ?.data?[index]
                                                                            .list
                                                                            ?.length ??
                                                                        0,
                                                                    (listIndex) =>
                                                                        ListTile(
                                                                      onTap: () => Get.to(() => PlayMovieScreen(
                                                                          downloadList: controller
                                                                              .movieModel
                                                                              ?.data
                                                                              ?.link
                                                                              ?.data?[index]
                                                                              .list?[listIndex])),
                                                                      focusNode: index == 0 &&
                                                                              listIndex ==
                                                                                  0
                                                                          ? controller
                                                                              .downloadFocus
                                                                          : null,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      iconColor:
                                                                          Colors
                                                                              .white,
                                                                      tileColor:
                                                                          darkBlue,
                                                                      titleTextStyle:
                                                                          const TextStyle(
                                                                              fontSize: 16),
                                                                      trailing:
                                                                          //   SizedBox(
                                                                          // width:
                                                                          //     Get.width /
                                                                          //         7,
                                                                          // child:
                                                                          //   Row(
                                                                          // mainAxisAlignment:
                                                                          //     MainAxisAlignment.spaceBetween,
                                                                          // crossAxisAlignment:
                                                                          //     CrossAxisAlignment.end,
                                                                          // children: [
                                                                          controller.movieModel?.data?.link?.data?[index].list?[listIndex].format == 'movie'
                                                                              ? const Icon(
                                                                                  Icons.play_arrow,
                                                                                  color: Colors.white,
                                                                                  size: 28,
                                                                                )
                                                                              : const SizedBox(),
                                                                      // InkWell(
                                                                      //   onTap: () => controller.openUrl(controller.movieModel?.data?.link?.data?[index].list?[listIndex]),
                                                                      //   child: const Icon(
                                                                      //     Icons.download,
                                                                      //     color: Colors.white,
                                                                      //   ),
                                                                      // ),
                                                                      // ],
                                                                      // ),
                                                                      // ),
                                                                      title:
                                                                          Text(
                                                                        controller.movieModel?.data?.link?.data?[index].list?[listIndex].title ??
                                                                            "",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ]),
                                                  ),
                                                ))),
                            ),
                            Divider(
                              color: Colors.grey,
                              height: Get.height / 18,
                            ),

                            // actors
                            AutoScrollTag(
                              key: const ValueKey(6),
                              controller: controller.pageScrollController,
                              index: 6,
                              child: SizedBox(
                                  child: Column(
                                      children: List.generate(
                                          controller.movieModel?.data?.cast
                                                  ?.length ??
                                              0,
                                          (index) => InkWell(
                                                focusNode: index == 0
                                                    ? controller.castFocus
                                                    : null,
                                                onTap: () =>
                                                    Get.to(() => SearchScreen(
                                                          title: "",
                                                          cast: controller
                                                              .movieModel
                                                              ?.data
                                                              ?.cast?[index]
                                                              .name,
                                                        )),
                                                child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  width: Get.width,
                                                  height: Get.height / 11,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: blackColor,
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xff3f3f3f))),
                                                  child: Row(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.network(
                                                            controller
                                                                    .movieModel
                                                                    ?.data
                                                                    ?.cast?[
                                                                        index]
                                                                    .image ??
                                                                "",
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Text(
                                                            controller
                                                                    .movieModel
                                                                    ?.data
                                                                    ?.cast?[
                                                                        index]
                                                                    .name ??
                                                                "",
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            controller
                                                                    .movieModel
                                                                    ?.data
                                                                    ?.cast?[
                                                                        index]
                                                                    .simple ??
                                                                "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff5f5f5f),
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                              )))),
                            ),
                            Divider(
                              color: Colors.grey,
                              height: Get.height / 18,
                            ),

                            // comments
                            AutoScrollTag(
                                key: const ValueKey(8),
                                controller: controller.pageScrollController,
                                index: 8,
                                child: SizedBox(
                                  child: Column(
                                    // controller: controller.commentScrollController,
                                    // physics: const BouncingScrollPhysics(
                                    //     parent: BouncingScrollPhysics()),
                                    children: [
                                      Obx(() => controller
                                              .replyId.value.isNotEmpty
                                          ? InkWell(
                                              onTap: () =>
                                                  controller.replyId.value = "",
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  child: Text(
                                                    "پاسخ به کامنت فعال شد. جهت حذف اینجا کلیک نمایید",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 12 *
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaleFactor),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox()),
                                      // text input
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          height: MediaQuery.sizeOf(context)
                                                  .height /
                                              5,
                                          child: TextFormField(
                                            controller:
                                                controller.commentController,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 5,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                                hintText: "نظر خود را ثبت کنید",
                                                hintStyle: const TextStyle(
                                                    color: Color(0xff5f5f5f)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Color(
                                                                0xff5f5f5f))),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Color(
                                                                0xff5f5f5f)))),
                                          ),
                                        ),
                                      ),

                                      // submit comment button
                                      InkWell(
                                        onTap: () async {
                                          FocusScope.of(context).unfocus();
                                          await controller.comment();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(8),
                                          margin: EdgeInsets.symmetric(
                                                  horizontal: Get.width / 8) +
                                              const EdgeInsets.only(bottom: 18),
                                          decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Text(
                                            "ثبت و ارسال",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),

                                      // comments
                                      Obx(
                                        () => controller.commentUpdate.value > 0
                                            ? Column(
                                                children: List.generate(
                                                    controller.movieModel?.data
                                                            ?.comment?.length ??
                                                        0,
                                                    (index) => InkWell(
                                                          focusNode: index == 0
                                                              ? controller
                                                                  .commentFocus
                                                              : null,
                                                          onTap: () {},
                                                          child: CommentWidget(
                                                            onReplyTap: (id) {
                                                              controller.replyId
                                                                  .value = id;
                                                              controller
                                                                  .pageScrollController
                                                                  .scrollToIndex(
                                                                      8);
                                                            },
                                                            commentModel: controller
                                                                    .movieModel
                                                                    ?.data
                                                                    ?.comment?[
                                                                index],
                                                            onLikeTap: (id) =>
                                                                controller
                                                                    .likeComment(
                                                                        id: id,
                                                                        way:
                                                                            'like'),
                                                            onDislikeTap: (id) =>
                                                                controller
                                                                    .likeComment(
                                                                        id: id,
                                                                        way:
                                                                            'dislike'),
                                                          ),
                                                        )))
                                            : const SizedBox(),
                                      )
                                    ],
                                  ),
                                )),
                            Divider(
                              color: Colors.grey,
                              height: Get.height / 18,
                            ),

                            // trailer
                            AutoScrollTag(
                              key: const ValueKey(10),
                              controller: controller.pageScrollController,
                              index: 10,
                              child: SizedBox(
                                  child: Column(
                                children: List.generate(
                                  controller
                                          .movieModel?.data?.trailer?.length ??
                                      0,
                                  (index) => InkWell(
                                    onTap: () async {
                                      if (controller.movieModel?.data
                                              ?.trailer?[index].type ==
                                          'trailer') {
                                        await controller.initTrailer(controller
                                                .movieModel
                                                ?.data
                                                ?.trailer?[index]
                                                .view ??
                                            "");
                                      }
                                    },
                                    child: TrailerWidget(
                                        trailerModel: controller
                                            .movieModel?.data?.trailer?[index]),
                                  ),
                                ),
                              )),
                            )
                          ]),
                    ),
                  ],
                ),
              ))),
    );
  }
}
