import 'package:flutter/material.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class HowToGetVetc extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  HowToGetVetc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'Как получить VETC',
        globalKey: _key,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        children: [
          HowToGetVetcTiles(
            title: 'Регистрация',
          ),
          HowToGetVetcTiles(
            title: 'Приглашение друга',
          ),
          HowToGetVetcTiles(
            title: 'Помощь приюту',
          ),
          HowToGetVetcTiles(
            title: 'Передержка',
          ),
          HowToGetVetcTiles(
            title: 'Выгул',
          ),
          HowToGetVetcTiles(
            title: 'Взять питомца в семью',
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class HowToGetVetcTiles extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var title;

  HowToGetVetcTiles({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: MyText(
        text: '$title',
        size: 15,
        color: kDarkGreyColor,
        fontFamily: 'Roboto',
      ),
      trailing: Wrap(
        spacing: 10.0,
        children: [
          MyText(
            text: '0',
            size: 18,
            weight: FontWeight.w700,
            color: kSecondaryColor,
            fontFamily: 'Roboto',
          ),
          Image.asset(
            'assets/images/Charity 3.png',
            height: 27,
          ),
        ],
      ),
    );
  }
}
