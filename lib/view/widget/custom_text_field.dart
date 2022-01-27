import 'package:flutter/material.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool obscureText;
  final String? Function(String? value)? validate;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyText(
                text: label,
                size: 12,
                weight: FontWeight.w700,
                color: kDarkGreyColor,
              ),
              Visibility(
                visible: obscureText,
                child: MyText(
                  paddingLeft: 5,
                  text: '*',
                  weight: FontWeight.w700,
                  size: 12,
                  color: kSecondaryColor,
                ),
              )
            ],
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            obscuringCharacter: "*",
            textAlignVertical: TextAlignVertical.center,
            validator: validate,
            style: const TextStyle(
              color: kDarkGreyColor,
              fontSize: 12,
            ),
            decoration: InputDecoration(
              suffix: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      size: 25,
                      color: kInputBorderColor,
                    ),
                  ),
                ],
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: kLightGreyColor,
                fontSize: 12,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kInputBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kInputBorderColor,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
