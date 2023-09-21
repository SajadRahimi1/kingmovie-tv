import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: blackColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: MediaQuery.sizeOf(context).height / 10,
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(
            color: Color(0xff5f5f5f),
          ))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                  color: Colors.white),
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
          ]),
        ),
      ),
    );
  }
}
