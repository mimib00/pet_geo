import 'package:flutter/material.dart';
import 'package:pet_geo/view/constant/constant.dart';

import 'my_text.dart';

// ignore: must_be_immutable
class SendBox extends StatelessWidget {
  SendBox({
    Key? key,
    this.hintText,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 45,
          color: kPrimaryColor,
          child: Center(
            child: TextField(
              cursorColor: const Color(0xffBEBEBE),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                color: kDarkGreyColor,
              ),
              decoration: InputDecoration(
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xfff2f2f2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 86,
                      height: 30,
                      child: Center(
                        child: MyText(
                          text: 'Отправить'.toUpperCase(),
                          size: 10,
                          color: kDarkGreyColor,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                hintText: '$hintText',
                hintStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  color: Color(0xffBEBEBE),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: kSecondaryColor,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: kSecondaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
