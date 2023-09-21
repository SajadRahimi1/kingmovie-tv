import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/services/menu_service.dart';
import 'package:king_movie/core/widgets/menu_item.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode nameFocus = FocusNode();
    nameFocus.requestFocus();
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: blackColor),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height / 45),
          child: Material(
            color: blackColor,
            child: InkWell(
              onTap: toProfileScreen,
              focusNode: nameFocus,
              child: Text(
                SingletonClass.instance.user?.name ?? "کاربر مهمان",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
        SingletonClass.instance.user == null
            ?
            /*ListTile(
                onTap: loginTap,
                textColor: Colors.white,
                title: Text(
                  "ورود / ثبت نام",
                  style: TextStyle(
                      fontSize: 12 * MediaQuery.of(context).textScaleFactor),
                ),
                trailing: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              )*/
            const MenuItem(
                title: "ورود / ثبت نام", icon: Icons.login, onTap: loginTap)
            : const MenuItem(
                onTap: toProfileScreen,
                title: "تنظیمات کاربری",
                icon: Icons.settings,
              ),
        if (SingletonClass.instance.user != null)
          const MenuItem(
            onTap: toVipScreen,
            title: "اشتراک ویژه دانلود",
            icon: Icons.downloading_rounded,
          ),
        if (SingletonClass.instance.user != null)
          const MenuItem(
            onTap: toReuestScreen,
            title: "درخواست ها",
            icon: Icons.movie,
          ),
          if (SingletonClass.instance.user != null)
            const MenuItem(
              onTap: toFavoriteScreen,
              title: 
                "لیست مورد علاقه",
              icon:
                Icons.star,
            ),
          if (SingletonClass.instance.user != null)
            const MenuItem(
              onTap: toTransactionScreen,
              title: 
                "سوابق پرداخت",
              icon: 
                Icons.payment,
            ),
          if (SingletonClass.instance.user != null)
            const MenuItem(
              onTap: toTicketsScreen,
              title: 
                "تیکت و پشتیبانی",
              icon: 
                Icons.support_agent,
            ),
          if (SingletonClass.instance.user != null)
            MenuItem(
              onTap: () {
                exit();
                Scaffold.of(context).closeDrawer();
              },
              title: 
                "خروج",
              icon:
                Icons.exit_to_app,
            ),
      ]),
    );
  }
}
