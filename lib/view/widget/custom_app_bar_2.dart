import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

import 'logo.dart';
import 'my_text.dart';

// ignore: must_be_immutable
class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(140);
  // ignore: prefer_typing_uninitialized_variables
  var title, customTitle;
  bool? haveTitle, haveSearch, haveFilter, addCustomTitle;
  GlobalKey<ScaffoldState>? globalKey;
  VoidCallback? onTitleTap;
  VoidCallback? showSearch;
  VoidCallback? showFilter;
  VoidCallback? onBackButtonOnTap;

  CustomAppBar2({Key? key,
    this.title,
    this.haveTitle = false,
    this.addCustomTitle = false,
    this.customTitle,
    this.haveSearch = false,
    this.haveFilter = false,
    this.globalKey,
    this.onTitleTap,
    this.showSearch,
    this.showFilter,
    this.onBackButtonOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: GestureDetector(
            onTap: () => globalKey!.currentState!.openDrawer(),
            child: Image.asset(
              'assets/images/Logo PG.png',
              height: 35,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
          child: textLogo(24),
        ),
      ),
      actions: const [SizedBox()],
      bottom: PreferredSize(
        preferredSize: const Size(0, 0),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: GestureDetector(
            onTap: onBackButtonOnTap ?? () => Get.back(),
            child: Image.asset(
              'assets/images/back_button.png',
              height: 35,
            ),
          ),
          minLeadingWidth: 70.0,
          title: haveTitle == true
              ? GestureDetector(
                  onTap: onTitleTap,
                  child: MyText(
                    paddingRight: 35.0,
                    text: '$title',
                    size: 18,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    align: TextAlign.center,
                  ),
                )
              : addCustomTitle == true
                  ? customTitle
                  : const SizedBox(),
          trailing: Wrap(
            spacing: 5.0,
            children: [
              haveSearch == true
                  ? GestureDetector(
                      onTap: showSearch,
                      child: Image.asset(
                        'assets/images/Serach.png',
                        height: 35,
                      ),
                    )
                  : haveFilter == true
                      ? GestureDetector(
                          onTap: () => globalKey!.currentState!.openEndDrawer(),
                          child: Image.asset(
                            'assets/images/Filter.png',
                            height: 35,
                          ),
                        )
                      : const SizedBox(
                          height: 35,
                          width: 37,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
