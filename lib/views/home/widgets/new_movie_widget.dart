import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/models/movie_widget_model.dart';
import 'package:king_movie/views/movie_detail/screens/movie_detail_screen.dart';

class NewMovieWidget extends StatelessWidget {
  const NewMovieWidget({
    super.key,
    required this.model, this.onFocus,
  });

  final MovieWidgetModel? model;
  final void Function(bool isFocus)? onFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        color: blackColor,
        child: InkWell(
          onFocusChange: onFocus,
          onTap: () =>
              Get.to(() => MovieDetailScreen(movieId: model?.id ?? "")),
          child: SizedBox(
            width: Get.width / 2.8,
            height: Get.height,
            child: Row(
              children: [
                SizedBox(
                    width: Get.width / 6.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: model?.poster == null
                          ? const SizedBox()
                          : Image.network(
                              model?.poster ?? "",
                              fit: BoxFit.fill,
                              height: Get.height,
                            ),
                    )),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      model?.title ?? "",
                      maxLines: 1,
                      style: const TextStyle(
                          color: Color(0xffffffff), fontSize: 13),
                    ),
                    Text(
                      model?.genre ?? "",
                      style: const TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
