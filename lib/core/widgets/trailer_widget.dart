import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/models/movie_model.dart';

class TrailerWidget extends StatelessWidget {
  const TrailerWidget({super.key, required this.trailerModel});
  final Trailer? trailerModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height / 3,
        child: Stack(children: [
          Image.network(
            trailerModel?.image ?? "",
            fit: BoxFit.fill,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 3,
          ),
          trailerModel?.type == 'trailer'
              ? Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height / 3,
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CircleAvatar(
                        // radius: MediaQuery.sizeOf(context).width / 15,
                        backgroundColor: Colors.white,
                        child: Center(
                            child: Icon(
                          Icons.play_arrow,
                          color: blackColor,
                          // size: MediaQuery.sizeOf(context).width / 14,
                        ))),
                  ),
                )
              : const SizedBox()
        ]),
      ),
    );
  }
}
