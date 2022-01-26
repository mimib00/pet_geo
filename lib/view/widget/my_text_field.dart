import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_geo/view/constant/constant.dart';

import 'my_text.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var hintText, lableText;
  bool? obsecure, staricIcon;
  TextEditingController? controller = TextEditingController();
  ValueChanged<String>? onChanged;

  MyTextField({
    Key? key,
    this.hintText,
    this.lableText,
    this.onChanged,
    this.controller,
    this.obsecure = false,
    this.staricIcon = false,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.staricIcon == true
                  ? MyText(
                      paddingLeft: 40,
                      text: '*',
                      weight: FontWeight.w700,
                      size: 12,
                      color: kSecondaryColor,
                    )
                  : const SizedBox(),
              MyText(
                text: '${widget.lableText}',
                size: 12,
                weight: FontWeight.w700,
                color: kDarkGreyColor,
              ),
            ],
          ),
          TextFormField(
            onChanged: widget.onChanged,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: kDarkGreyColor,
            style: const TextStyle(
              color: kDarkGreyColor,
              fontSize: 12,
            ),
            obscureText: widget.obsecure!,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              suffix: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        print(widget.controller!.text);
                      }
                      // widget.controller!.clear();
                    },
                    child: Image.asset(
                      'assets/images/Delite all.png',
                      height: 20,
                    ),
                  ),
                ],
              ),
              hintText: '${widget.hintText}',
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
