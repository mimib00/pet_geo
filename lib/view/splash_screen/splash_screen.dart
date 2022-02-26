import 'package:flutter/material.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              children: [
                logo(180),
                const SizedBox(
                  height: 20,
                ),
                textLogo(30),
              ],
            ),
            Center(
              child: MyText(
                text: 'Your Pet Space App',
                size: 14,
                fontFamily: 'Robboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
