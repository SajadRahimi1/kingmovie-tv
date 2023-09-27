import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:king_movie/models/movie_model.dart';
import 'package:king_movie/viewmodels/play_movie_viewmodel.dart';
import 'package:king_movie/views/movie_detail/widgets/top_video_widget.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:king_movie/core/extensions/duration_extension.dart';

class PlayMovieScreen extends StatefulWidget {
  const PlayMovieScreen({super.key, required this.downloadList});
  final DownloadList? downloadList;

  @override
  State<PlayMovieScreen> createState() => _PlayMovieScreenState();
}

class _PlayMovieScreenState extends State<PlayMovieScreen> {
  late PlayMovieViewModel controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    controller = Get.put(PlayMovieViewModel(widget.downloadList));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(bottom: 5),
        child: RawKeyboardListener(
            focusNode: controller.movieFocusNode,
            onKey: (RawKeyEvent event) async {
              if (event is RawKeyDownEvent &&
                  event.data is RawKeyEventDataAndroid) {
                RawKeyEventDataAndroid data =
                    event.data as RawKeyEventDataAndroid;

                if (data.keyCode == 19) {
                  controller.showButtonsTimer.cancel();
                  controller.showButtons.value = true;
                  // Up arrow tapped
                  controller.subtitleFocusNode.requestFocus();
                } else if (data.keyCode == 20) {
                  controller.showButtonsTimer.cancel();
                  controller.showButtons.value = true;

                  // Down arrow tapped
                  controller.sliderFocusNode.requestFocus();
                } else if (data.keyCode == 21) {
                  controller.showButtonsTimer.cancel();
                  controller.showButtons.value = true;
                  // Left
                  if (controller.sliderFocusNode.hasFocus) {
                    controller.isSlider = true;
                    print(controller.movieDuration);
                    controller.moviePostion.value += 10;
                  }
                } else if (data.keyCode == 22) {
                  controller.showButtonsTimer.cancel();
                  controller.showButtons.value = true;
                  // Right
                  if (controller.sliderFocusNode.hasFocus) {
                    controller.isSlider = true;
                    if (controller.moviePostion > 10) {
                      controller.moviePostion.value -= 10;
                    }
                  }
                } else if (data.keyCode == 23) {
                  controller.showButtonsTimer.cancel();
                  controller.showButtons.value = true;
                  // Center
                  controller.movieFocusNode.requestFocus();
                }
              } else if (event is RawKeyUpEvent &&
                  event.data is RawKeyEventDataAndroid) {
                RawKeyEventDataAndroid data =
                    event.data as RawKeyEventDataAndroid;
                if (data.keyCode == 21) {
                  controller.showButtonsTimer = Timer(
                      const Duration(seconds: 3),
                      () => controller.showButtons.value = false);
                  // Left
                  if (controller.sliderFocusNode.hasFocus) {
                    controller.moviePostion.value =
                        controller.moviePostion.toInt();
                    await controller.player.pause();
                    await controller.player.seek(
                        Duration(seconds: controller.moviePostion.toInt()));
                    await controller.player.play();
                    controller.isSlider = false;
                  }
                } else if (data.keyCode == 22) {
                  controller.showButtonsTimer = Timer(
                      const Duration(seconds: 3),
                      () => controller.showButtons.value = false);
                  // Left
                  if (controller.sliderFocusNode.hasFocus) {
                    controller.moviePostion.value =
                        controller.moviePostion.toInt();
                    await controller.player.pause();
                    await controller.player.seek(
                        Duration(seconds: controller.moviePostion.toInt()));
                    await controller.player.play();
                    controller.isSlider = false;
                  }
                } else if (data.keyCode == 19) {
                  controller.showButtonsTimer = Timer(
                      const Duration(seconds: 3),
                      () => controller.showButtons.value = false);
                } else if (data.keyCode == 23) {
                  controller.showButtonsTimer = Timer(
                      const Duration(seconds: 3),
                      () => controller.showButtons.value = false);
                }
              }
            },
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    // video
                    Obx(() => Video(
                          controller: controller.controller,
                          subtitleViewConfiguration:
                              controller.subtitleViewConfiguration.value,
                          controls: NoVideoControls,
                        )),

                    // widgets
                    Obx(() => Visibility(
                          visible: controller.showButtons.value,
                          child: SizedBox(
                            width: Get.width,
                            height: Get.height,
                            child: Column(children: [
                              // top widgets
                              Row(
                                children: [
                                  const Spacer(),
                                  Material(
                                    color: Colors.transparent,
                                    child: SubtitleWidget(
                                        focusNode: controller.subtitleFocusNode,
                                        player: controller.player),
                                  ),
                                  Material(
                                      color: Colors.transparent,
                                      child: AudioWidget(
                                          player: controller.player)),
                                  /*Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        focusColor: Colors.red,
                                                        focusNode: controller.subtitleFocusNode,
                                                        onTap: () async {
                                                          TextStyle? subtitleStyle =
                                                              await showModalBottomSheet(
                                                                  context: context,
                                                                  builder: (context) =>
                                                                      const SettingBottomSheet());
                                                          if (subtitleStyle != null) {
                                                            controller
                                                                    .subtitleViewConfiguration.value =
                                                                SubtitleViewConfiguration(
                                                                    style: subtitleStyle);
                                                          }
                                                        },
                                                        child: const Icon(
                                                          Icons.settings,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                  */
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        focusColor: Colors.red,
                                        onTap: () => Get.back(),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              const Spacer(),

                              // bottom widgets
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Obx(() => Text(
                                      '${controller.position.value.label(reference: controller.duration.value)} / ${controller.duration.value.label(reference: controller.duration.value)}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                              ),
                              SizedBox(
                                width: Get.width,
                                height: Get.height / 20,
                                child: SliderTheme(
                                  data: SliderTheme.of(context)
                                      .copyWith(overlayColor: Colors.red),
                                  child: Obx(() => Slider(
                                        focusNode: controller.sliderFocusNode,
                                        secondaryActiveColor: Colors.red,
                                        min: 0,
                                        max: 4600,
                                        value: controller.moviePostion.value
                                            .toDouble(),
                                        onChanged: (value) async {},
                                        onChangeEnd: (value) async {
                                          controller.isSlider = true;
                                          controller.moviePostion.value =
                                              value.toInt();
                                          await controller.player.pause();
                                          await controller.player.seek(
                                              Duration(seconds: value.toInt()));
                                          await controller.player.play();
                                          controller.isSlider = false;
                                        },
                                      )),
                                ),
                              )
                            ]),
                          ),
                        ))
                  ],
                ))),
      ),
    );
  }
}
