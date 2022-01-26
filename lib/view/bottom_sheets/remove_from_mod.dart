import 'package:flutter/material.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class RemoveFromMod extends StatelessWidget {
  VoidCallback? onTap;

  RemoveFromMod({Key? key,
    this.onTap,
  }) : super(key: key);

  List title = [
    'Удалить из модераторов',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        itemBuilder: (context, index) => ListTile(
          onTap: onTap,
          title: Center(
            child: MyText(
              size: 15,
              color: kDarkGreyColor,
              text: title[index],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: kLightGreyColor,
        ),
        itemCount: title.length,
      ),
    );
  }
}
