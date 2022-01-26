import 'package:flutter/material.dart';
import 'package:pet_geo/view/constant/constant.dart';

import 'my_text.dart';

// ignore: must_be_immutable
class SearchBox extends StatelessWidget {
  SearchBox({
    Key? key,
    this.hintText,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  var hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: TextField(
            cursorColor: kDarkGreyColor,
            decoration: InputDecoration(
              hintText: '$hintText',
              hintStyle: const TextStyle(
                color: kInputBorderColor,
                fontSize: 12,
                fontFamily: 'Roboto',
              ),
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Serach.png',
                    height: 35,
                    color: kInputBorderColor,
                  ),
                ],
              ),
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                      color: kLightGreyColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: MyText(
                        text: 'поиск',
                        size: 10,
                        color: kDarkGreyColor,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kInputBorderColor,
                  width: 1,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kInputBorderColor,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
